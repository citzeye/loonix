#!/bin/bash

# --- 1. Update ZSHRC (Local Copy) ---
cp /home/citz/loonix/.config/zshs/.zshrc ~/.zshrc

# --- 2. Reload Wallpaper (Hyprpaper) ---
# Tambahin & biar terminal gak nungguin
pkill hyprpaper
hyprpaper -c /home/citz/loonix/.config/hypr/hyprpaper.conf > /dev/null 2>&1 &

# --- 3. Reload config Bar & Notif ---
# Tambahin & biar terminal gak nungguin
pkill waybar
waybar -c /home/citz/loonix/.config/waybar/config.jsonc -s /home/citz/loonix/.config/waybar/style.css > /dev/null 2>&1 &
pkill dunst
dunst &

# --- 4. Reload config Hyprland ---
hyprctl reload

# --- 5. Reload config Kitty ---
pkill -USR1 kitty

notify-send "Loonix" "Nuclear Refresh Done! 🚀"