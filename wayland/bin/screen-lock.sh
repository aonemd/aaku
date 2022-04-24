#!/bin/sh

if [ $1 ]; then
  lockbg="$1"
else
  lockbg=$(find $HOME/Pictures/Wallpapers/. -type f | shuf -n 1)
fi

swaylock --daemonize -k -l \
  --image $lockbg \
  --inside-color 37344500 \
  --inside-clear-color 00000000 \
  --inside-ver-color 407ee7ff \
  --inside-wrong-color f22c40ff \
  --key-hl-color 407ee7ff \
  --bs-hl-color 407ee7ff \
  --ring-color ffffffff \
  --ring-clear-color ffffffff \
  --ring-wrong-color ffffffff \
  --ring-ver-color ffffffff \
  --line-uses-ring \
  --line-color 00000000 \
  --text-color 00000000 \
  --text-clear-color 00000000 \
  --text-wrong-color 00000000 \
  --text-ver-color 00000000 \
  --separator-color 00000000 \
  --font 'NotoSans Nerd Font Mono:style=Thin,Regular 40'
