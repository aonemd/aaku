#!/bin/sh

# send command to all nvim instances
#
# https://github.com/chmln/nvim-ctrl/issues/1

# LINUX
# ls $XDG_RUNTIME_DIR/nvim.*.0 \
# 	| xargs -I {} nvim --server {} --remote-send "$1"

# MACOS
fd "nvim\..*\.0" /private/var/  \
  | xargs -I {} nvim --server {} --remote-send "$1"
