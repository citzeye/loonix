#!/bin/bash

# =========================================================
# LOONIX INSTALLER (HYBRID VERSION)
# =========================================================

# --- Identification ---
# Automatically detects if the user is the Creator (Bre)
USER_NOW=$(whoami)
IS_DEV=false
[[ "$USER_NOW" == "citz" ]] && IS_DEV=true

# Get the absolute path of the repository to avoid "broken links"
REPO_ROOT=$(pwd)

echo "--- Starting Full Installation: Loonix Project ---"

# 1. Essential Folders
mkdir -p "$HOME/Documents"
mkdir -p "$HOME/Pictures/Screenshots"
mkdir -p "$HOME/.config"

# 2. Permissions
# Ensure all scripts in the repo are executable before running
chmod +x "$REPO_ROOT"/.config/scripts/*.sh 2>/dev/null

# 3. Priority Run (Apps & Drivers)
# Installing core dependencies first
PRIORITY=("apps")
for p in "${PRIORITY[@]}"; do
    script_file="$REPO_ROOT/.config/scripts/$p.sh"
    [ -f "$script_file" ] && bash "$script_file" install
done

# 4. CONFIG DEPLOYMENT (Symlink vs Copy)
echo "🔗 Deploying Configurations..."
DOTS_DIR="$REPO_ROOT/.config"
TARGET_DIR="$HOME/.config"

for folder in "$DOTS_DIR"/*/; do
    folder_name=$(basename "$folder")
    
    # Filter internal tool folders
    [[ "$folder_name" == "apps" || "$folder_name" == "scripts" ]] && continue

    if [ "$IS_DEV" = true ]; then
        # For Creator: Absolute Symlink
        # Use -snf to handle symlinking directories correctly
        ln -snf "$DOTS_DIR/$folder_name" "$TARGET_DIR/"
        echo "   [DEV] Symlinked $folder_name"
    else
        # For User: Physical Copy
        rm -rf "$TARGET_DIR/$folder_name" # Clean old version first
        cp -r "$folder" "$TARGET_DIR/"
        echo "   [USER] Installed $folder_name"
    fi
done

# Special handle for .zshrc
if [ "$IS_DEV" = true ]; then
    ln -sf "$DOTS_DIR/zshs/.zshrc" "$HOME/.zshrc"
else
    cp "$DOTS_DIR/zshs/.zshrc" "$HOME/.zshrc"
fi

# 5. Remaining Scripts
for script in "$REPO_ROOT"/.config/scripts/*.sh; do
    filename=$(basename "$script")
    # Skip already executed priority scripts and the re-run script
    [[ " ${PRIORITY[*]} " =~ " ${filename%.sh} " || "$filename" == "r-all.sh" ]] && continue
    bash "$script" install
done

# 6. Post-Installation for Cloners
if [ "$IS_DEV" = false ]; then
    # Point system to ~/loonix/.config if not in Dev mode
    if ! grep -q "XDG_CONFIG_HOME" "$HOME/.zshrc"; then
        echo 'export XDG_CONFIG_HOME="$HOME/loonix/.config"' >> "$HOME/.zshrc"
    fi
fi

echo "--- 🎉 Loonix Installation Finished! ---"
echo "Note: Please restart your terminal or run 'source ~/.zshrc'"