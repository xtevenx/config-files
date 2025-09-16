#!/bin/bash

SELECTION="$(printf "󰒉 Area\n󰍹 Output\n󰓩 Window" | fuzzel --dmenu -l 3 -w 18 -p "Select an option: " | awk '{print $2}')"

case $SELECTION in
  Area)
    grimshot --notify save area;;
  Output)
    grimshot --notify save output;;
  Window)
    grimshot --notify save window;;
esac
