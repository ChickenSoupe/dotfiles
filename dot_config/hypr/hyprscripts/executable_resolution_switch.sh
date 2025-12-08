#!/bin/bash

# Display resolution options
options="2880x1800 @ 120Hz (Scale 1.8)
2880x1800 @ 60Hz (Scale 1.8)
1920x1200 @ 60Hz (Scale 1.0)
1440x900 @ 60Hz (Scale 1.0)
1280x800 @ 60Hz (Scale 1.0)"

# Show dmenu and get selection
selected=$(echo "$options" | vicinae dmenu -p "Select Display Resolution:")


# Exit if no selection made (user pressed ESC)
[[ -z "$selected" ]] && exit 0

# Function to restart way-edges
restart_wayedges() {
	sleep 1
    pkill way-edges && way-edges &
}

# Apply the selected resolution
case "$selected" in
    "2880x1800 @ 120Hz (Scale 1.8)")
        hyprctl keyword monitor eDP-1,2880x1800@120,0x0,1.8
        restart_wayedges
        ;;
    "2880x1800 @ 60Hz (Scale 1.8)")
        hyprctl keyword monitor eDP-1,2880x1800@60,0x0,1.8
        restart_wayedges
        ;;
    "1920x1200 @ 60Hz (Scale 1.0)")
        hyprctl keyword monitor eDP-1,1920x1200@60,0x0,1.0
        restart_wayedges
        ;;
    "1440x900 @ 60Hz (Scale 1.0)")
        hyprctl keyword monitor eDP-1,1440x900@60,0x0,1.0
        restart_wayedges
        ;;
    "1280x800 @ 60Hz (Scale 1.0)")
        hyprctl keyword monitor eDP-1,1280x800@60,0x0,1.0
        restart_wayedges
        ;;
    *)
        echo "Invalid selection"
        exit 1
        ;;
esac
