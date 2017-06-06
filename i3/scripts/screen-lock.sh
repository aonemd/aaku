#!/usr/bin/env zsh

# i3lock screen lock script
# requires imagemagick, scrot

lockbg="/tmp/screen.png"

if [ $1 ]; then
  lockfg="$1"
else
  lockfg="$HOME/.config/i3/scripts/lockfg.png"
fi

scrot -z "$lockbg"

convert "$lockbg" -blur 0x5 "$lockbg"
convert "$lockbg" \( "$lockfg" -scale 50% -gravity center \) -composite "$lockbg"

setxkbmap us  # change layout to us

i3lock -u -t -n -e -i "$lockbg" >> /dev/null

rm "$lockbg"
