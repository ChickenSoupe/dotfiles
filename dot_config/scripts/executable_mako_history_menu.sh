#!/bin/bash

# Configuration for vicinae dmenu
NAV_TITLE="Mako Notification History"
SECTION_TITLE="{count} Notifications"
PLACEHOLDER="Filter by App or Content..."

# Pipe makoctl history output into awk for formatting, then into vicinae dmenu
makoctl history | awk '
/^Notification [0-9]+:/ {
    # Start of a new notification
    if (app_name != "" && content != "") {
        # Print the previous notification before starting the new one
        print app_name " : " content
    }
    # Reset variables for the new entry
    app_name = ""
    content = ""
    
    # Extract the Notification content (everything after "Notification X: ")
    # This assumes the content is on the same line as the Notification header.
    sub(/^Notification [0-9]+: /, "", $0)
    content = $0
}

/App name:/ {
    # Extract the App name (everything after "App name: ")
    # The trim removes leading/trailing spaces and the label itself
    app_name = $0
    sub(/.*App name: */, "", app_name)
}

# The END block runs after all lines are processed
END {
    # Print the very last notification
    if (app_name != "" && content != "") {
        print app_name " : " content
    }
}' | vicinae dmenu -n "$NAV_TITLE" -s "$SECTION_TITLE" -p "$PLACEHOLDER"
