// ==UserScript==
// @name         Youtube Focus (JS)
// @description  Script that hides many Youtube features.
// @version      0.1.0
// @author       xtevenx
// @license      Unlicense
// @match        https://www.youtube.com/*
// @run-at       document-start
// ==/UserScript==

const SUB_URL = 'https://www.youtube.com/feed/subscriptions';
const WAT_URL = 'https://www.youtube.com/watch?v=';

// https://stackoverflow.com/questions/24297929/javascript-to-listen-for-url-changes-in-youtube-html5-player/30199872#30199872
document.addEventListener('yt-navigate-finish', function() {
  if (window.location.href !== SUB_URL && !window.location.href.startsWith(WAT_URL)) {
    window.location.href = SUB_URL; return;
  }
});
