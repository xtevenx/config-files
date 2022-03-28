// ==UserScript==
// @name         Youtube Focus (JS)
// @description  Script that hides some Youtube features.
// @version      0.2.0
// @author       xtevenx
// @license      Unlicense
// @match        https://www.youtube.com/*
// @run-at       document-start
// ==/UserScript==

const HOME_URL = 'https://www.youtube.com/';
const SUB_URL = 'https://www.youtube.com/feed/subscriptions';

// https://stackoverflow.com/questions/24297929/javascript-to-listen-for-url-changes-in-youtube-html5-player/30199872#30199872
document.addEventListener('yt-navigate-finish', function() {
  let href = window.location.href;
  if (href.includes('?')) { href = href.substr(0, href.indexOf('?')); }
  if (href === HOME_URL) { window.location.href = SUB_URL; }
});

new MutationObserver(function(mutationArray, _) {
  for (const m of mutationArray) { m.addedNodes.forEach((e) => {
    if (typeof e.id !== 'undefined' && e.id === 'logo') {
      e.href = '/feed/subscriptions';
      e.onclick = () => { window.location.href = SUB_URL; }; } }); }
}).observe(document, { subtree: true, childList: true });
