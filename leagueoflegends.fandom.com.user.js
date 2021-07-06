// ==UserScript==
// @name         LoL Wiki Clean
// @description  Clean style for the League of Legends Fandom Wiki.
// @version      0.0.0-dev
// @author       xtevenx
// @namespace    xtevenx
// @license      Unlicense
// @match        https://leagueoflegends.fandom.com/*
// @run-at       document-idle
// ==/UserScript==

// The locations of the elements are in parentheses after they are described.
// These locations are relative to the main page information.

// Remove the global navigation bar (left).
for (const e in document.getElementsByClassName("global-navigation")) {
    e.remove();
}

// Remove the comments section (bottom).
document.getElementById("mw-data-after-content").remove();

// Remove the random links section (bottom).
document.getElementById("mixed-content-footer").remove();

// Remove the global page footer (bottom).
for (const e in document.getElementsByClassName("wds-global-footer")) {
    e.remove();
}
