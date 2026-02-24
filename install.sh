#!/bin/bash
# Loonix User Installer
# Target: Cloner
# Logic: Physical copy to ~/.config, system runs from ~/loonix/.config

REPO_DIR="$HOME/loonix"

echo "Starting Loonix Installation..."

# 1. Physical copy of configuration files
mkdir -p "$HOME/.config"
cp -r "$REPO_DIR"/.config/* "$HOME/.config/"

# 2. Copy critical dotfiles
cp "$REPO_DIR/.config/zshs/.zshrc" "$HOME/.zshrc"

# 3. Ensure system components point to ~/loonix/.config
# We inject the HOME into shell profile
if ! grep -q "XDG_CONFIG_HOME" "$HOME/.zshrc"; then
    echo 'export XDG_CONFIG_HOME="$HOME/loonix/.config"' >> "$HOME/.zshrc"
fi

# 4. Fix permissions for the cloned environment
chmod -R +x "$REPO_DIR"/.config/hypr/scripts/

# 5. DONE
echo "Installation finished. Loonix is ready. Please restart your session."