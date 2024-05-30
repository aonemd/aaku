#!/bin/sh

lock=~/workspace/aaku/wayland/bin/screen-lock.sh

case $(wofi -d -L 8 -l 3 -W 110 -x -105 -y 20 \
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
    $lock && systemctl suspend
    ;;
  "Hibernate")
    $lock && systemctl hibernate
    ;;
  "Logout")
    swaymsg exit
    ;;
  "Lock")
    $lock
    ;;
esac
