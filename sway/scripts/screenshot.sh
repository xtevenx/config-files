#!/bin/bash
 
entries="󰒉 Area\n󰍹 Output\n󰓩 Window"
 
selected=$(echo -e $entries | wofi --conf=$HOME/.config/wofi/config.widgets --style=$HOME/.config/wofi/style.widgets.css | awk '{print $2}')
 
case $selected in
  Area)
    /usr/share/sway/scripts/grimshot --notify save area;;
  Output)
    /usr/share/sway/scripts/grimshot --notify save output;;
  Window)
    /usr/share/sway/scripts/grimshot --notify save window;;
esac
