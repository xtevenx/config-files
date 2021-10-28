// ==UserScript==
// @name         Font Override (JS)
// @description  Script that uses forces standardized fonts for all web pages.
// @version      0.1.2-dev
// @author       xtevenx
// @license      Unlicense
// @match        https://*/*
// @run-at       document-start
// ==/UserScript==

const fontFaces = ['Fira Sans', 'Fira Mono'];
//const fontFaces = ['Comic Sans MS', 'ComicMono NF'];
const updateInterval = 250;  // milliseconds

function fixFontFamily(e) {
  if (typeof e.style !== 'undefined') {
    const fontFamily = window.getComputedStyle(e, null).getPropertyValue('font-family');
    const properFontFamily = fontFaces[+fontFamily.toLowerCase().includes('mono')];
    if (!fontFamily.startsWith(properFontFamily)) {
      e.style.fontFamily = properFontFamily + ',' + fontFamily;
    }
  }
}

function fixNodeTree(e) {
  e.childNodes.forEach(fixNodeTree);
  fixFontFamily(e);
}


// Set up and deploy a mutation observer.
let lastUpdate = 0;
new MutationObserver(function(mutationArray, _) {
  const now = performance.now();
  if (now >= lastUpdate + updateInterval) {
    fixNodeTree(document.body);
    lastUpdate = now;
  }
}).observe(document, { subtree: true, childList: true });
