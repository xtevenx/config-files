// ==UserScript==
// @name         LoL Wiki Clean (JS)
// @description  Clean script for the League of Legends Fandom Wiki.
// @version      0.0.0-dev
// @author       xtevenx
// @license      Unlicense
// @match        https://*.fandom.com/*
// @run-at       document-end
// ==/UserScript==

// The locations of the elements are in parentheses after they are described.
// These locations are relative to the main page information.

// Remove the global navigation bar (left).
for (const e of document.getElementsByClassName("global-navigation")) {
    e.remove();
}

// Remove the information panel (right).
for (const e of document.getElementsByClassName("page__right-rail")) {
    e.remove();
}

// Remove the comments section (bottom).
document.getElementById("mw-data-after-content").remove();

// Remove the random links section (bottom).
document.getElementById("mixed-content-footer").remove();

// Remove the global page footer (bottom).
for (const e of document.getElementsByClassName("wds-global-footer")) {
    e.remove();
}

// Remove the tiny menu (bottom right).
document.getElementById("WikiaBar").remove();
