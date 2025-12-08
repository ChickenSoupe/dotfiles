#!/bin/bash

# System utilities menu for dmenu
options="󰊠 Toggle Refresh Rate
󱐋 Toggle Conservation Mode
󰊗 Toggle Game Mode"

choice=$(echo -e "$options" | vicinae dmenu --placeholder "System Utils")

case "$choice" in
    "󰊠 Toggle Refresh Rate")
        # Get current refresh rate of eDP-1
        current_rate=$(hyprctl monitors | grep -A 10 "Monitor eDP-1" | grep -oP '\d+x\d+@\K\d+')
        
        # Toggle between 60 and 120
        if [ "$current_rate" = "120" ]; then
            new_rate=60
        else
            new_rate=120
        fi
        
        # Apply new refresh rate
        hyprctl keyword monitor "eDP-1,2880x1800@$new_rate,0x0,1.5"
        notify-send "Hyprland" "Switched eDP-1 to $new_rate Hz"
        ;;
    
    "󱐋 Toggle Conservation Mode")
        path="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"
        
        if [ ! -e "$path" ]; then
            notify-send -u critical "Error" "Conservation mode file not found"
            exit 1
        fi
        
        current_status=$(cat "$path")
        
        case "$current_status" in
            0)
                echo 1 | pkexec tee "$path" > /dev/null
                notify-send "Battery" "Conservation Mode enabled (80% cap)"
                ;;
            1)
                echo 0 | pkexec tee "$path" > /dev/null
                notify-send "Battery" "Conservation Mode disabled (full charge)"
                ;;
            *)
                notify-send -u critical "Error" "Unexpected conservation mode value: $current_status"
                exit 2
                ;;
        esac
        ;;
    
    "󰊗 Toggle Game Mode")
        # Check if game mode is enabled by checking if animations are disabled
        animations_enabled=$(hyprctl getoption animations:enabled | grep -oP 'int: \K\d+')
        
        if [ "$animations_enabled" = "0" ]; then
            # Game mode is ON, disable it
            hyprctl --batch "\
                keyword animations:enabled 1;\
                keyword decoration:shadow:enabled 1;\
                keyword decoration:blur:enabled 1;\
                keyword general:gaps_in 5;\
                keyword general:gaps_out 10;\
                keyword general:border_size 2;\
                keyword decoration:rounding 8;\
                keyword general:allow_tearing 0"
            notify-send "Hyprland" "Game Mode disabled"
        else
            # Game mode is OFF, enable it
            hyprctl --batch "\
                keyword animations:enabled 0;\
                keyword decoration:shadow:enabled 0;\
                keyword decoration:blur:enabled 0;\
                keyword general:gaps_in 0;\
                keyword general:gaps_out 0;\
                keyword general:border_size 1;\
                keyword decoration:rounding 0;\
                keyword general:allow_tearing 1"
            notify-send "Hyprland" "Game Mode enabled"
        fi
        ;;
    
    *)
        # User cancelled or invalid selection
        exit 0
        ;;
esac
