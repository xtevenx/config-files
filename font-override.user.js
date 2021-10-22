// ==UserScript==
// @name         Font Override (JS)
// @description  Script that uses forces standardized fonts for all web pages.
// @version      0.0.0-dev
// @author       xtevenx
// @license      Unlicense
// @match        https://*/*
// @run-at       document-end
// ==/UserScript==

for (const e of document.getElementsByTagName('*')) {
  if (typeof e.style !== 'undefined') {
    const fontFamily = window.getComputedStyle(e, null).getPropertyValue('font-family');
    if (fontFamily.toLowerCase().includes('mono')) {
      e.style.fontFamily = 'Fira Mono,' + fontFamily;
    } else {
      e.style.fontFamily = 'Fira Sans,' + fontFamily;
    }
  }
}
