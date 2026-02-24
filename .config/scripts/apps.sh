#!/bin/bash

# --- UI Enhancement ---
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}==========================================${NC}"
echo -e "${BLUE}     LOONIX APPS - Master Installation     ${NC}"
echo -e "${BLUE}==========================================${NC}"

# --- 1. Path Setup ---
# Fixed to ensure REPO_ROOT is accurate regardless of execution path
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OFFLINE_BIN_DIR="$REPO_ROOT/.config/apps"

# --- 2. Hardware Detection ---
GPU_LIST=$(lspci | grep -E "VGA|3D")
echo -e "${YELLOW}Hardware Detected:${NC}\n$GPU_LIST"

# --- 3. Offline Installation (Primary) ---
if [[ "$1" == "install" ]]; then
    echo -e "\n${GREEN}📦 Installing Offline Packages from .config/apps...${NC}"
    if [ -d "$OFFLINE_BIN_DIR" ] && ls "$OFFLINE_BIN_DIR"/*.pkg.tar.zst 1> /dev/null 2>&1; then
        sudo pacman -U --noconfirm "$OFFLINE_BIN_DIR"/*.pkg.tar.zst
    else
        echo -e "${RED}⚠️ No offline packages found. Skipping to online sync...${NC}"
    fi
fi

# --- 4. Online Sync (Master List) ---
# Added: 'go' (for loonix-login), 'webkit2gtk-4.1' (for Wails), 'mpv-mpris' (for notifications)
PACMAN_APPS=(
    "go" "webkit2gtk-4.1" "base-devel" "pkgconf" # Development essentials
    "limine" "sddm" "hyprland" "xdg-desktop-portal-hyprland" "uwsm" 
    "kitty" "wofi" "dunst" "libnotify" "micro" "thunar" 
    "thunar-archive-plugin" "thunar-volman" "gvfs" "gvfs-mtp" "file-roller"
    "p7zip" "unzip" "unrar" "zoxide" "eza" "zsh" "btop" 
    "fastfetch" "grim" "slurp" "cliphist" "wl-clipboard" 
    "polkit-kde-agent" "network-manager-applet" "fontconfig" 
    "nwg-look" "ttf-jetbrains-mono-nerd" "hyprshot" "hyprpaper" 
    "hypridle" "hyprlock" "qt5-wayland" "qt6-wayland" "qt5ct"
    "zsh-autosuggestions" "zsh-syntax-highlighting" "mesa" 
    "wireplumber" "libpulse" "libgtop" "bluez" "bluez-utils" "networkmanager" 
    "dart-sass" "upower" "python" "pacman-contrib" "mpv-mpris"
    "power-profiles-daemon" "brightnessctl" "swww" "gtk3" "gtk4" 
    "adwaita-icon-theme" "ufw" "pavucontrol"
)

echo -e "\n${GREEN}🌐 Syncing missing dependencies...${NC}"
sudo pacman -S --needed --noconfirm "${PACMAN_APPS[@]}"

# --- 5. GPU Drivers Injection ---
# Dell 7559 (GTX 960M + HD Graphics 530)
echo -e "\n${GREEN}🎮 Configuring GPU Drivers...${NC}"
if echo "$GPU_LIST" | grep -iq "NVIDIA"; then
    echo -e "${YELLOW}Optimizing for NVIDIA (Hybrid/DKMS)...${NC}"
    sudo pacman -S --needed --noconfirm nvidia-dkms nvidia-utils python-gpustat opencl-nvidia lib32-nvidia-utils
elif echo "$GPU_LIST" | grep -iq "Intel"; then
    echo -e "${YELLOW}Optimizing for Intel Graphics...${NC}"
    sudo pacman -S --needed --noconfirm libva-intel-driver libvdpau-va-gl vulkan-intel
fi

echo -e "\n${GREEN}✅ Apps and Drivers installation finished.${NC}"