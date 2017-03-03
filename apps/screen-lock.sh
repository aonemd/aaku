#!/bin/zsh

# i3lock screen lock script
# requires imagemagick, scrot

lockbg="/tmp/screen.png"

if [ $1 ]; then
  lockfg="$1"
else
  lockfg="$WK/aaku/apps/lockfg.png"
fi

scrot -z "$lockbg"

convert "$lockbg" -scale 10% -scale 1000% -blur 0x8 "$lockbg"
convert "$lockbg" \( "$lockfg" -scale 77% -gravity center \) -composite -matte "$lockbg"

setxkbmap us  # change layout to us

i3lock -u -n -e -i "$lockbg" >> /dev/null

rm "$lockbg"
