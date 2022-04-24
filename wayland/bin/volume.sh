#!/bin/sh

send_notification() {
  is_muted=$(pactl get-sink-mute @DEFAULT_SINK@ | grep '[yes|no]' | awk '{print $2}')
  if [ $is_muted == "yes" ]; then
    notify-send -u low "Volume" "Muted" -i audio-volume-muted
  else
    val=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
    notify-send -u low -h int:value:$val "Volume" "$val%" -i audio-volume-high
  fi
}

case "$1" in
  up)
    pactl set-sink-volume @DEFAULT_SINK@ +5%
    send_notification
    ;;
  down)
    pactl set-sink-volume @DEFAULT_SINK@ -5%
    send_notification
    ;;
  mute)
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    send_notification
    ;;
  mute-mic)
    pactl set-source-mute @DEFAULT_SOURCE@ toggle

    is_muted=$(pactl get-source-mute @DEFAULT_SOURCE@ | grep '[yes|no]' | awk '{print $2}')
    if [ $is_muted == "yes" ]; then
      notify-send -u low "Microphone" "Muted" -i microphone-sensitivity-muted
    else
      notify-send -u low "Microphone" "Unmuted" -i audio-input-microphone-high
    fi
    ;;
  *)
    echo "Usage: $0 {up|down|mute|mute-mic}"
    exit 2
esac

exit 0
