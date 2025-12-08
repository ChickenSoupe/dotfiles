#!/bin/bash

# Hyprland layout switcher for dmenu

# Define available layouts
layouts="dwindle\nmaster\nscroll"

# Show dmenu and get selection
selected=$(echo -e "$layouts" | vicinae dmenu -p "Select Layout:")

# Exit if nothing selected
[ -z "$selected" ] && exit 0

# Apply the selected layout
case "$selected" in
    "dwindle")
    	hyprctl reload
        hyprctl keyword general:layout dwindle
        notify-send "Hyprland Layout" "Switched to Dwindle (normal tiling)"
        ;;
    "master")
    	hyprctl reload
        hyprctl keyword source ~/.config/hypr/keybindings/master.conf
        hyprctl keyword general:layout master
        notify-send "Hyprland Layout" "Switched to Master"
        ;;
    "scroll")
    	hyprctl reload
    	hyprctl keyword source ~/.config/hypr/keybindings/scrolling.conf
        hyprctl keyword general:layout scrolling
        notify-send "Hyprland Layout" "Switched to Scroller"
        ;;
esac
