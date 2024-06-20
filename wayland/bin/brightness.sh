#!/bin/sh

send_notification() {
  val=$(($(brightnessctl g) * 100/$(brightnessctl m)))
  notify-send -u low -h int:value:$val string:x-canonical-private-synchronous:brightness "Brightness" "$val%" -i notification-display-brightness
}

case "$1" in
  up)
    brightnessctl -q set +5%
    send_notification
    ;;
  down)
    brightnessctl -q set 5%-
    send_notification
    ;;
  *)
    echo "Usage: $0 {up|down}"
    exit 2
esac

exit 0
