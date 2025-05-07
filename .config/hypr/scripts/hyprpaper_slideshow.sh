#!/bin/bash

# Folder containing your wallpapers
WALLPAPER_DIR="$HOME/Pictures/wallhaven/219"
# Monitor name (change this to match your setup)
MONITOR="DP-2"

# Time (in seconds) between wallpaper changes
INTERVAL=1800  # 5 minutes

# Loop forever
while true; do
    for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png}; do
        [[ -e "$img" ]] || continue  # skip if no match
	echo "$img"	
	# hyprctil hyprpaper preload "$img"
	hyprctl hyprpaper reload ,"$img"
        # hyprctl hyprpaper wallpaper "$MONITOR,$img"
        sleep "$INTERVAL"
    done
done

