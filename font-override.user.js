// ==UserScript==
// @name         Font Override (JS)
// @description  Script that forces standardized fonts for all web pages.
// @version      0.2.1
// @author       xtevenx
// @license      Unlicense
// @match        https://*/*
// @run-at       document-start
// ==/UserScript==

const fontFaces = ['Open Sans', 'Fira Code'];
//const fontFaces = ['Fira Sans', 'Fira Mono'];
//const fontFaces = ['Comic Sans MS', 'ComicMono NF'];

function fixFontFamily(e) {
  if (typeof e.style !== 'undefined') {
    const fontFamily = window.getComputedStyle(e, null).getPropertyValue('font-family');
    const properFontFamily = fontFaces[+fontFamily.toLowerCase().includes('mono')];
    if (!fontFamily.startsWith(properFontFamily)) {
      e.style.fontFamily = properFontFamily + ',' + fontFamily;
    }
  }
}

new MutationObserver(function(mutationArray, _) {
  for (const m of mutationArray) { m.addedNodes.forEach(fixFontFamily); }
}).observe(document, { subtree: true, childList: true });
