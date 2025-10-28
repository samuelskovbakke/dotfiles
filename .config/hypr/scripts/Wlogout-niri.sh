#!/usr/bin/env bash
# wlogout launcher for Niri (dynamic top/bottom margins and button count)

# Check if wlogout is already running
if pgrep -x "wlogout" > /dev/null; then
    pkill -x "wlogout"
    exit 0
fi

# Path to your layout JSON file
LAYOUT_JSON="$HOME/.config/wlogout/layout"

# Count the number of buttons defined in layout JSON
# Assumes each button object starts with { and label field
BUTTON_COUNT=$(grep -c '"label"' "$LAYOUT_JSON")
# Ensure at least 1 button
BUTTON_COUNT=${BUTTON_COUNT:-1}

# Get focused output info from Niri
OUTPUT_INFO=$(niri msg focused-output)

# Extract monitor height
HEIGHT=$(echo "$OUTPUT_INFO" | grep -oP 'Current mode: \d+x\K\d+')
# Extract scale
SCALE=$(echo "$OUTPUT_INFO" | grep -oP 'Scale: \K\d+')
SCALE=${SCALE:-1}

# Dynamic T and B calculation
# Proportional to screen height
# You can tweak the factor (here 0.15 and 0.15) to adjust spacing
T_VAL=$(awk "BEGIN {printf \"%.0f\", $HEIGHT * 0.15 * $SCALE}")
B_VAL=$(awk "BEGIN {printf \"%.0f\", $HEIGHT * 0.15 * $SCALE}")

# Launch wlogout with correct parameters
wlogout --protocol layer-shell -b "$BUTTON_COUNT" -T "$T_VAL" -B "$B_VAL" &
