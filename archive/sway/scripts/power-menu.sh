#!/bin/bash

entries="󰜉 Reboot\n󰐥 Shutdown"

selected=$(echo -e $entries | wofi --conf=$HOME/.config/wofi/config.widgets --style=$HOME/.config/wofi/style.widgets.css | awk '{print $2}')

case $selected in
  Reboot)
    exec systemctl reboot;;
  Shutdown)
    exec systemctl poweroff;;
esac
