// ==UserScript==
// @name         Font Override (JS)
// @description  Script that uses forces standardized fonts for all web pages.
// @version      0.0.0-dev
// @author       xtevenx
// @license      Unlicense
// @match        https://*/*
// @run-at       document-end
// ==/UserScript==

(function foo(n) {
  for (const e of n.childNodes) {
    foo(e);
    if (typeof e.style !== 'undefined') {
      const fontFamily = window.getComputedStyle(e, null).getPropertyValue('font-family');
      if (fontFamily.toLowerCase().includes('mono')) {
        e.style.fontFamily = 'Fira Mono,' + fontFamily;
      } else {
        e.style.fontFamily = 'Fira Sans,' + fontFamily;
      }
    }
  }
})(document);
