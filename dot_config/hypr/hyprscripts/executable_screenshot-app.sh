#!/usr/bin/env bash

# ~/.config/hypr/scripts/screenshot_focused_satty.sh

set -euo pipefail

# 1. Dependency Check
for cmd in grim hyprctl jq satty; do
    command -v "$cmd" >/dev/null 2>&1 || { echo "$cmd missing" >&2; exit 1; }
done

# 2. Define Output Location and Filename
# Satty will handle the saving, so we just need the path format for its output flag.
out_dir="$HOME/Pictures/Screenshots"
# Use PPM format for piping, but save the final file as PNG
save_path="$out_dir/satty-focused-$(date +%Y%m%d-%H%M%S).png"

mkdir -p "$out_dir"

# 3. Get Active Window Geometry
# Get JSON for the active window
window_json="$(hyprctl -j activewindow)"

# Extract geometry: X, Y, Width, Height
# Format: X,Y WxH
# jq pulls the [x, y] position and the [w, h] size arrays.
# We then use a simple awk command to format it as the "geometry string" grim expects.
geometry=$(echo "$window_json" | jq -r '[.at[0], .at[1], .size[0], .size[1]] | join(" ")' | awk '{print $1","$2" "$3"x"$4}')

# Check if geometry was successfully extracted
if [[ -z "${geometry:-}" ]]; then
    echo "Error: Could not determine active window geometry." >&2
    exit 1
fi

# 4. Capture, Pipe to Satty, and Save
# grim captures the geometry, outputs raw PPM data to stdout
# satty reads from stdin, opens fullscreen for annotation, and saves the final PNG
echo "Capturing focused window geometry: $geometry"
grim -g "$geometry" -t ppm - | \
    satty --filename - \
          --fullscreen \
          --output-filename "$save_path"

echo "Capture complete. Annotated image saved to: $save_path"
