#!/bin/bash

# 1. Tentukan Folder (Sesuai repo lo)
WP_DIR="$HOME/loonix/.config/wallpapers"

# 2. Pilih file secara acak
SELECTED_WP=$(ls "$WP_DIR"/*.{png,jpg,jpeg} | shuf -n 1)

# 3. Eksekusi ke Hyprpaper
# Kita preload dulu file barunya, baru pasang
hyprctl hyprpaper preload "$SELECTED_WP"
hyprctl hyprpaper wallpaper "HDMI-A-1,$SELECTED_WP"

# 4. Bersihkan RAM
# Penting biar laptop Dell lo nggak sesak napas nyimpen cache wallpaper lama
sleep 1
hyprctl hyprpaper unload all