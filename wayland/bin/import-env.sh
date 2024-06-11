#!/usr/bin/env bash

set -e

[[ -n $HYPRLAND_DEBUG_CONF ]] && exit 0

_envs=(
	# display
	WAYLAND_DISPLAY
	DISPLAY
	# xdg
	USERNAME
	XDG_BACKEND
	XDG_CURRENT_DESKTOP
	XDG_SESSION_TYPE
	XDG_SESSION_ID
	XDG_SESSION_CLASS
	XDG_SESSION_DESKTOP
	XDG_SEAT
	XDG_VTNR
	# hyprland
	HYPRLAND_CMD
	HYPRLAND_INSTANCE_SIGNATURE
	# sway
	SWAYSOCK
	# ssh
	SSH_AUTH_SOCK
)

dbus-update-activation-environment --systemd "${_envs[@]}"

for v in "${_envs[@]}"; do
	if [[ -n ${!v} ]]; then
		tmux setenv -g "$v" "${!v}"
	fi
done
