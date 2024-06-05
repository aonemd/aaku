#!/bin/sh
nwg-drawer \
  -r \
  -pbexit "hyprctl dispatch exit 1" \
  -pbpoweroff "systemctl poweroff" \
  -pbreboot "systemctl reboot" \
  -pbsleep "systemctl suspend" \
  -pbsize 46 \
  -wm "hyprland" \
  -term "alacritty"
