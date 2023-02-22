#!/bin/bash
 
entries="Output Area Window"
 
selected=$(printf '%s\n' $entries | wofi --conf=$HOME/.config/wofi/config.widgets --style=$HOME/.config/wofi/style.widgets.css | awk '{print tolower($1)}')
 
case $selected in
  output)
    /usr/share/sway/scripts/grimshot --notify save output;;
  area)
    /usr/share/sway/scripts/grimshot --notify save area;;
  window)
    /usr/share/sway/scripts/grimshot --notify save window;;
esac
