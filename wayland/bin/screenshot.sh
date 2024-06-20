#!/bin/sh

filename="$HOME/Pictures/screenshots/$(date +"screenshot_%Y-%m-%d_%H-%M-%S.png")"
open_cmd="eog"
edit_cmd="swappy -f"
copy_cmd="wl-copy"

notify() {
  action=$(notify-send -u low -i "$filename" "Screenshot" --action=copy=Copy --action=edit=Edit --action=open=Open)

  if [ $action = 'open' ]; then
    $open_cmd $filename
  elif [ $action = 'edit' ]; then
    $edit_cmd "$filename"
  elif [ $action = 'copy' ]; then
    $copy_cmd < "$filename"
  fi
}

delay() {
  sleep $1
}

all() {
  if [ -n "$2" ]; then
    delay "$2"
  fi

  grim "$filename"
  notify
}

window() {
	area=$(hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')

  grim -g "$area" "$filename"
  notify
}

selection() {
  grim -g "$(slurp)" "$filename"
  notify
}

case $1 in
  all)
    all "$@"
    ;;
  window)
    window
    ;;
  selection)
    selection
    ;;
  *)
    echo "Usage: $0 {all \$DELAY|window|selection}"
    exit 2
esac
