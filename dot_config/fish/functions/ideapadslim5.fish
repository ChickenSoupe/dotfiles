
# Function 1: Toggle refresh rate between 60Hz and 120Hz
function toggle_rr

    set current_rate (hyprctl monitors | grep -A 10 "Monitor eDP-1" | grep -oP '\d+x\d+@\K\d+')
    
    # Toggle between 60 and 120
    if test "$current_rate" = "120"
        set new_rate 60
    else
        set new_rate 120
    end
    
    # Apply new refresh rate
    hyprctl keyword monitor "eDP-1,2880x1800@$new_rate,0x0,1.5"
    notify-send "Hyprland" "Switched eDP-1 to $new_rate Hz"
end

# Function 2: Toggle blur and transparency
function toggle_blur
    set current_blur (hyprctl getoption decoration:blur:enabled | grep -oP '(?<=int: )\d+')
    
    if test "$current_blur" = "1"
        # Blur is currently enabled, disable blur and transparency
        hyprctl keyword decoration:blur:enabled false
        hyprctl keyword windowrulev2 "opacity 1.0 override 1.0 override, class:.*"
        notify-send "Hyprland" "Blur and transparency disabled"
    else
        # Blur is currently disabled, enable blur and transparency
        hyprctl keyword decoration:blur:enabled true
        hyprctl keyword windowrulev2 "opacity 0.89 override 0.89 override, class:.*"
        notify-send "Hyprland" "Blur and transparency enabled"
    end
end

# Function 3: Toggle battery conservation mode
function toggle_bat
    set pathbat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
                        if not test -e $pathbat
                            notify-send "Battery Error" "conservation_mode file not found at $pathbat"
                            exit 1
                        end
                        set current_status (cat $pathbat)
                        switch $current_status
                            case 0
                                notify-send "Battery" "Enabling Conservation Mode (charge capped at ~60%)..."
                                if pkexec sh -c "echo 1 > $pathbat"
                                    notify-send "Battery" "Conservation Mode enabled - charging capped at ~60%"
                                else
                                    notify-send "Battery Error" "Failed to enable conservation mode"
                                end
                            case 1
                                notify-send "Battery" "Disabling Conservation Mode (allow full charge)..."
                                if pkexec sh -c "echo 0 > $pathbat"
                                    notify-send "Battery" "Conservation Mode disabled - full charging allowed"
                                else
                                    notify-send "Battery Error" "Failed to disable conservation mode"
                                end
                            case '*'
                                notify-send "Battery Error" "Unexpected value ($current_status) in $pathbat"
                                exit 2
                        end
end
