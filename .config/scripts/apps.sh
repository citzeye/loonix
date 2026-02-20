#!/bin/bash

# =========================================================
#  LOONIX - MASTER INSTALLATION SCRIPT (Full Version)
# =========================================================

# --- Warna buat gaya dikit ---
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}--- LOONIX: Hardware Scanning ---${NC}"

# Detect VGA or 3D controllers
GPU_LIST=$(lspci | grep -E "VGA|3D")
echo -e "Detected Hardware:\n$GPU_LIST"

# =========================================================
#  PART 1: DEFINISI PAKET
# =========================================================

PACMAN_APPS=(
    # --- Base System & Boot ---
    "limine" "sddm" "hyprland" "xdg-desktop-portal-hyprland" "uwsm" 
    "kitty" "wofi" "dunst" "libnotify"
    
    # --- Apps & Utilities ---
    "micro" "thunar" "thunar-archive-plugin" "gvfs" 
    "zoxide" "eza" "zsh" "btop" "fastfetch"
    
    # --- Screenshot & Clipboard ---
    "grim" "slurp" "cliphist" "wl-clipboard" 
    "polkit-kde-agent" "network-manager-applet"
    
    # --- Themes & Fonts ---
    "ttf-nerd-fonts-symbols" "fontconfig" "nwg-look" 
    "ttf-jetbrains-mono-nerd"
    
    # --- Hyprland Ecosystem ---
    "hyprshot" "hyprpaper" "hypridle" "hyprlock"
    
    # --- Qt & Wayland ---
    "qt5-wayland" "qt6-wayland" "qt5ct"
    
    # --- Shell & Plugins ---
    "zsh-autosuggestions" "zsh-syntax-highlighting"
    
    # --- Drivers & Hardware ---
    "mesa" "wireplumber" "libgtop" "bluez" "bluez-utils" 
    "networkmanager" "dart-sass" "upower" "python" 
    "pacman-contrib" "power-profiles-daemon" "brightnessctl"
    
    # --- System Libraries ---
    "gtk3" "gtk4" "libpulse" "adwaita-icon-theme" "ufw"
)

AUR_APPS=(
    "bibata-cursor-theme-bin" "brave-browser-bin" "aylurs-gtk-shell-git"
    "ags-hyprpanel-git" "grimblast-git" "hyprpicker" "matugen-bin" 
    "hyprsunset-git" "gpu-screen-recorder-git"
)

# =========================================================
#  PART 2: EKSEKUSI INSTALASI (Offline Priority)
# =========================================================

echo -e "\n${GREEN}📦 Starting Installation...${NC}"

# 1. Cek Folder Apps Lokal (Offline)
OFFLINE_PATH="$HOME/loonix/.config/apps"
if [ -d "$OFFLINE_PATH" ] && [ "$(ls -A $OFFLINE_PATH/*.pkg.tar.zst 2>/dev/null)" ]; then
    echo -e "${YELLOW}📂 Found offline packages in $OFFLINE_PATH. Installing...${NC}"
    sudo pacman -U --needed --noconfirm $OFFLINE_PATH/*.pkg.tar.zst
else
    echo -e "${YELLOW}ℹ️ No offline packages found or folder empty. Skipping to online sync.${NC}"
fi

# 2. Install sisanya dari repo resmi
echo -e "${GREEN}🌐 Syncing remaining official packages...${NC}"
sudo pacman -S --needed --noconfirm "${PACMAN_APPS[@]}"

# 3. Handle GPU Drivers Secara Otomatis
if echo "$GPU_LIST" | grep -iq "NVIDIA"; then
    echo -e "${BLUE}-> Installing NVIDIA drivers (GTX 960M detected)${NC}"
    sudo pacman -S --needed --noconfirm nvidia-dkms nvidia-utils python-gpustat
fi

if echo "$GPU_LIST" | grep -iq "Intel"; then
    echo -e "${BLUE}-> Installing Intel graphics drivers${NC}"
    sudo pacman -S --needed --noconfirm vulkan-intel intel-media-driver
fi

if echo "$GPU_LIST" | grep -iq "AMD|ATI"; then
    echo -e "${BLUE}-> Installing AMD graphics drivers${NC}"
    sudo pacman -S --needed --noconfirm xf86-video-amdgpu vulkan-radeon
fi

# =========================================================
#  PART 3: AUR & TOOLS
# =========================================================

# Bootstrapping yay
if ! command -v yay &> /dev/null; then
    echo -e "${YELLOW}📦 Yay not found. Bootstrapping yay...${NC}"
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm && cd - && rm -rf /tmp/yay
fi

echo -e "${GREEN}💎 Installing AUR packages...${NC}"
# Kita coba install offline dulu kalau ada file AUR .zst di apps
yay -S --needed --noconfirm "${AUR_APPS[@]}"

# =========================================================
#  PART 4: SYSTEM CONFIG (Zsh & Firewall)
# =========================================================

echo -e "${GREEN}🔧 Finalizing System Config...${NC}"

# Zsh default
if [ "$SHELL" != "$(which zsh)" ]; then
    sudo chsh -s $(which zsh) $USER
fi

# UFW Setup
sudo systemctl enable --now ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw --force enable

echo -e "\n${BLUE}🎉 ===== LOONIX INSTALLED SUCCESSFULLY ===== 🎉${NC}"
echo "Note: Please reboot to apply all changes."