#!/bin/sh

lock=~/workspace/aaku/wayland/bin/screen-lock.sh

case $(wofi -d \
    << EOF | sed 's/^ *//'
    Shutdown
    Reboot
    Suspend
    Hibernate
    Logout
    Lock
    Cancel
EOF
) in
  "Shutdown")
    systemctl poweroff
    ;;
  "Reboot")
    systemctl reboot
    ;;
  "Suspend")
    systemctl suspend
    ;;
  "Hibernate")
    systemctl hibernate
    ;;
  "Logout")
    hyprctl dispatch exit 1
    ;;
  "Lock")
    $lock
    ;;
esac
