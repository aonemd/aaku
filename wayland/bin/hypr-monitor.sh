#! /usr/bin/env sh

# original: https://gist.github.com/miyl/7c4ebc95c5a02f84f36a769a3690cde6
#
# A hyprland script for a laptop-external-monitor setup, toggling between which is in use

# Launch at startup to make hyprland disable the internal monitor if an external monitor is detected and enabled
# Additionally it's called with a keybind to switch between a laptop monitor and an external display
# Ideally the conditional monitor behaviour was instead done directly in hyprland.conf, but I'm not sure whether that's possible
#
# Relevant info:
# - hyprctl monitors: identifies currently enabled monitors
# - hyprctl monitors all: identifies ALL connected monitors - including those not in use
#
# Suggested use:
# Add this line somewhere after the regular monitor configuration in hyprland.conf:
# exec = /path/to/hyprland-monitors-toggle.sh
# Add a keybind to run this script on demand:
# bind =,SomeKeyHere, exec, /path/to/hyprland-monitors-toggle.sh

move_all_workspaces_to_monitor() {
  TARGET_MONITOR="$1"

  hyprctl workspaces | grep ^workspace | cut --delimiter ' ' --fields 3 | xargs -I '{}' hyprctl dispatch moveworkspacetomonitor '{}' "$TARGET_MONITOR"

  # Previous approach
  #hyprctl swapactiveworkspaces $EXTERNAL_MONITOR $INTERNAL_MONITOR
}

# TODO: Detect these instead of hardcoding them
INTERNAL_MONITOR="eDP-1"
EXTERNAL_MONITOR="DP-1"

NUM_MONITORS=$(hyprctl monitors all | grep --count Monitor)
NUM_MONITORS_ACTIVE=$(hyprctl monitors | grep --count Monitor)

if [ "$NUM_MONITORS" == 1 ]; then
  exit
fi

# For initial startup if you use hyprland's default monitor settings:
# Turn off the laptop monitor if it + another monitor is active
if [ "$NUM_MONITORS_ACTIVE" -ge 2 ] && hyprctl monitors | cut --delimiter ' ' --fields 2 | grep --quiet ^$INTERNAL_MONITOR; then
    # Doing this I hopefully end up on workspace 1 on the external monitor rather than 2 at startup
    move_all_workspaces_to_monitor $EXTERNAL_MONITOR
    hyprctl keyword monitor "$INTERNAL_MONITOR, disable"
    # Alternate fix to ensure I start on workspace 1
    hyprctl dispatch workspace 1
    exit
fi

# For dynamically toggling which monitor is active later via a keybind
if [ "$NUM_MONITORS" -gt 1 ]; then # Handling multiple monitors
  if hyprctl monitors | cut --delimiter ' ' --fields 2 | grep --quiet ^$EXTERNAL_MONITOR; then
    hyprctl keyword monitor $INTERNAL_MONITOR,highrr,auto,1
    move_all_workspaces_to_monitor $INTERNAL_MONITOR
    hyprctl keyword monitor "$EXTERNAL_MONITOR, disable"
  else
    hyprctl keyword monitor $EXTERNAL_MONITOR,preferred,auto,1.5
    move_all_workspaces_to_monitor $EXTERNAL_MONITOR
    hyprctl keyword monitor "$INTERNAL_MONITOR, disable"
  fi
else  # If the external monitor is disconnected without running this script first, it might become the case that no monitor is on - therefore turn on the laptop monitor!
    hyprctl keyword monitor $INTERNAL_MONITOR,highrr,auto,1
    move_all_workspaces_to_monitor $INTERNAL_MONITOR
fi
