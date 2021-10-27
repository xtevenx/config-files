// ==UserScript==
// @name         Font Override (JS)
// @description  Script that uses forces standardized fonts for all web pages.
// @version      0.0.1-dev
// @author       xtevenx
// @license      Unlicense
// @match        https://*/*
// @run-at       document-end
// ==/UserScript==

const fontFaces = ['Fira Sans', 'Fira Mono'];
//const fontFaces = ['Comic Sans MS', 'ComicMono NF'];

(function foo(e) {
  e.childNodes.forEach(foo);
  if (typeof e.style !== 'undefined') {
    const fontFamily = window.getComputedStyle(e, null).getPropertyValue('font-family');
    e.style.fontFamily = fontFaces[+fontFamily.toLowerCase().includes('mono')] + ',' + fontFamily;
  }
})(document.body);
