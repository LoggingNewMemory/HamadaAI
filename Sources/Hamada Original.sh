#!/bin/sh

# Define file paths
GAME_LIST="/storage/emulated/0/HAMADA/game.txt"
GAME_SCRIPT="/data/adb/modules/HamadaAI/Scripts/game.sh"
NORMAL_SCRIPT="/data/adb/modules/HamadaAI/Scripts/normal.sh"

# Check if game.txt exists
if [ ! -f "$GAME_LIST" ]; then
    echo "Error: $GAME_LIST not found"
    exit 1
fi

# Initialize variables
prev_screen_status=""
last_executed=""  # Track which script was last executed

# Infinite loop
while true; do
    # Build filter expression from game.txt
    app_list_filter="grep -o"
    while IFS= read -r app_package || [ -n "$app_package" ]; do
        filter=$(echo "$app_package" | awk '!/ /')
        if [ -n "$filter" ]; then
            app_list_filter+=" -e $filter"
        fi
    done < "$GAME_LIST"
    
    # Check screen status
    current_screen_status=$(dumpsys window | grep "mScreenOn" | grep false)
    
    # Only detect screen status changes, don't reset last_executed
    if [ "$current_screen_status" != "$prev_screen_status" ]; then
        prev_screen_status="$current_screen_status"
        echo "Screen status changed"
    fi
    
    # Only proceed with app detection if screen is on
    if [ -z "$current_screen_status" ]; then
        # Get current foreground app using dumpsys window
        window=$(dumpsys window | grep package | $app_list_filter | tail -1)
        
        # Check if the current app is in game.txt and execute appropriate script only if state changed
        if [ -n "$window" ]; then
            # Game package detected
            if [ "$last_executed" != "game" ]; then
                echo "Game package detected: $window"
                sh "$GAME_SCRIPT"
                last_executed="game"
            fi
        else
            # Non-game package detected
            if [ "$last_executed" != "normal" ]; then
                echo "Non-game package detected"
                sh "$NORMAL_SCRIPT"
                last_executed="normal"
            fi
        fi
    fi
    
    sleep 2
done

# Convert to ARM64 Android Assembly, The assembly code must be work as same as the original .sh script