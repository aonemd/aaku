#!/bin/sh

case "$1" in
  up)
    wpctl set-volume @DEFAULT_SINK@ 5%+

    val=$(wpctl get-volume @DEFAULT_SINK@ | grep -oP 'Volume: \K.*' | awk '{print $1 * 100}')
    notify-send -u low -h int:value:$val -h string:x-canonical-private-synchronous:volume "Volume" "$val%" -i audio-volume-high
    ;;
  down)
    wpctl set-volume @DEFAULT_SINK@ 5%-

    val=$(wpctl get-volume @DEFAULT_SINK@ | grep -oP 'Volume: \K.*' | awk '{print $1 * 100}')
    notify-send -u low -h int:value:$val -h string:x-canonical-private-synchronous:volume "Volume" "$val%" -i audio-volume-high
    ;;
  mute)
    wpctl set-mute @DEFAULT_SINK@ toggle

    if wpctl get-volume @DEFAULT_SINK@ | grep -q "[MUTED]"; then
      notify-send -u low -h string:x-canonical-private-synchronous:volume "Volume" "Muted" -i audio-volume-muted
    else
      val=$(wpctl get-volume @DEFAULT_SINK@ | grep -oP 'Volume: \K.*' | awk '{print $1 * 100}')
      notify-send -u low -h string:x-canonical-private-synchronous:volume "Volume" "$val%" -i audio-volume-high
    fi
    ;;
  mute-mic)
    wpctl set-mute @DEFAULT_SOURCE@ toggle

    if wpctl get-volume @DEFAULT_SOURCE@ | grep -q "[MUTED]"; then
      notify-send -u low -h string:x-canonical-private-synchronous:microphone "Microphone" "Muted" -i microphone-sensitivity-muted
    else
      notify-send -u low -h string:x-canonical-private-synchronous:microphone "Microphone" "Unmuted" -i audio-input-microphone-high
    fi
    ;;
  *)
    echo "Usage: $0 {up|down|mute|mute-mic}"
    exit 2
esac

exit 0
