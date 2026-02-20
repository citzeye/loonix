#!/bin/bash

cd "$(dirname "$0")"
chmod +x ./*.sh 2>/dev/null

TARGET_DIR="$HOME/.local/share/applications"
mkdir -p "$TARGET_DIR"

echo "🚀 Syncing and overwriting .desktop files..."
cp -vf ./*.desktop "$TARGET_DIR/"
chmod 644 "$TARGET_DIR"/*.desktop

update-desktop-database "$TARGET_DIR" 2>/dev/null
echo "✨ Done! Semua shortcut udah standby di sistem dengan permission yang bener."