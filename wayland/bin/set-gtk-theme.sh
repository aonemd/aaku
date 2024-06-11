#!/bin/sh

GTK_THEME='Colloid-dark'
ICON_THEME='Colloid'
CURSOR_THEME='Capitaine Cursors'
XCURSOR_SIZE=24
HYPRCURSOR_SIZE=24
GTK_FONT_NAME='Noto Sans Regular 11'

config="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-3.0/settings.ini"

gnome_schema="org.gnome.desktop.interface"
gtk_theme="$(grep -s 'gtk-theme-name' "$config" | sed 's/.*\s*=\s*//')"
icon_theme="$(grep -s 'gtk-icon-theme-name' "$config" | sed 's/.*\s*=\s*//')"
cursor_theme="$(grep -s 'gtk-cursor-theme-name' "$config" | sed 's/.*\s*=\s*//')"
font_name="$(grep -s 'gtk-font-name' "$config" | sed 's/.*\s*=\s*//')"

gsettings set "$gnome_schema" gtk-theme "${gtk_theme:=$GTK_THEME}"
gsettings set "$gnome_schema" icon-theme "${icon_theme:=$ICON_THEME}"
gsettings set "$gnome_schema" cursor-theme "${cursor_theme:=$CURSOR_THEME}"
gsettings set "$gnome_schema" font-name "${font_name:=$GTK_FONT_NAME}"
# gsettings set org.gnome.desktop.wm.preferences button-layout '' && # remove window buttons

# hyprctl setcursor $CURSOR_THEME $HYPRCURSOR_SIZE &&
# export XCURSOR_THEME=$CURSOR_THEME
# export XCURSOR_SIZE=$XCURSOR_SIZE
# export HYPRCURSOR_THEME=$CURSOR_THEME
# export HYPRCURSOR_SIZE=$HYPRCURSOR_SIZE
# export QT_QPA_PLATFORMTHEME=qt5ct # change to qt6ct if you have that
