#!/bin/bash

echo "--- Installing Comprehensive App List ---"

# 1. Install Apps via Pacman
APPS=(
    "hyprland" "xdg-desktop-portal-hyprland" "uwsm"
    "kitty" "wofi" "waybar" "dunst" "libnotify"
    "micro" "thunar" "thunar-archive-plugin" "gvfs"
    "swww" "zoxide" "eza" "zsh" "htop" "fastfetch"
    "grim" "slurp" "cliphist" "wl-clipboard"
    "polkit-kde-agent" "network-manager-applet"
    "ttf-nerd-fonts-symbols" "fontconfig"
    "nwg-look" "hyprshot"
    "qt5-wayland" "qt6-wayland" "qt5ct"
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
)

sudo pacman -S --needed "${APPS[@]}" --noconfirm

# 2. Install Oh My Zsh (Silent/Unattended)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 3. Install Powerlevel10k Theme
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "$P10K_DIR" ]; then
    echo "Downloading P10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
fi

# 4. Ganti Default Shell ke Zsh
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s $(which zsh)
fi

echo "--- Apps & ZSH Setup DONE! ---"
