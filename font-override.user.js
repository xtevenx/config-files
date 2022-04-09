// ==UserScript==
// @name         Font Override (JS)
// @description  Script that forces standardized fonts for all web pages.
// @version      0.2.4
// @author       xtevenx
// @license      Unlicense
// @match        https://*/*
// @run-at       document-start
// ==/UserScript==

const fontFaces = ['Open Sans', 'Fira Mono'];
//const fontFaces = ['Comic Sans MS', 'ComicMono NF'];

const ignoreFonts = ['inherit', 'Material Icons'];

function fixFontFamily(e) {
  if (typeof e.style !== 'undefined') {
    const fontFamily = window.getComputedStyle(e, null).getPropertyValue('font-family');
    if (ignoreFonts.some((x) => fontFamily.includes(x))) { return; }
    e.style.fontFamily = fontFaces[+fontFamily.toLowerCase().includes('mono')];
  }
}

new MutationObserver(function(mutationArray, _) {
  for (const m of mutationArray) { m.addedNodes.forEach(fixFontFamily); }
}).observe(document, { subtree: true, childList: true });
