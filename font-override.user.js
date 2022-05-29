// ==UserScript==
// @name         Font Override (JS)
// @description  Script that forces standardized fonts for all web pages.
// @version      0.2.14
// @author       xtevenx
// @license      Unlicense
// @match        https://*/*
// @run-at       document-start
// ==/UserScript==

const fontFaces = ['Open Sans', 'Fira Mono'];
//const fontFaces = ['Comic Sans MS', 'ComicMono NF'];

const ignoreFonts = [
  'inherit',
  'anchorjs-icons',
  'docons',
  'FabricMDL2Icons',
  'Font Awesome',
  'FontAwesome',
  'fontello',
  'Glyphicons Halflings',
  'glyphicons halflings',
  'GMP Icons',
  'icomoon',
  'lichess',
  'Material Icons'
];

function fixFontFamily(e) {
  if (typeof e.style !== 'undefined') {
    const fontFamily = window.getComputedStyle(e, null).getPropertyValue('font-family');
    if (!ignoreFonts.some((x) => fontFamily.includes(x))) {
      e.style.fontFamily = fontFaces[+fontFamily.toLowerCase().includes('mono')];
    }
  }
}

new MutationObserver(function(mutationArray, _) {
  mutationArray.forEach((m) => m.addedNodes.forEach(fixFontFamily));
}).observe(document, { subtree: true, childList: true });
