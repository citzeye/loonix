# =========================================================
#!/usr/bin/env zsh
#  ZSH CONFIGURATION (LOONIX MASTER)
# =========================================================

# --- Environment Variables (WAJIB PALING ATAS) ---
      export EDITOR='code --wait'
      export VISUAL='code --wait'
      export QT_QPA_PLATFORMTHEME=qt5ct 
      export XDG_RUNTIME_DIR=/run/user/$UID
      export PATH="$HOME/.config/scripts:$HOME/.config/locals/bin:$(go env GOPATH)/bin:$PATH"

      # Fix Driver buat Wails & Cage for some hardware
      export WEBKIT_DISABLE_GPU_LEVEL=1
      export WLR_NO_HARDWARE_CURSORS=1

# --- Prompt Setup (The Creator Aesthetic) ---
      get_breadcrumb() {
        local path_str="${PWD/#$HOME/%n% }"
        local formatted="${path_str//\// }"
        echo "${formatted}"
      }

      setopt prompt_subst
      set_prompt() {
          PROMPT="%F{#4dff71} %m %f%F{#D1DAE3}$(get_breadcrumb)%f %F{#7D63C4} %f
"
      }
      precmd_functions+=(set_prompt)

      # Cursor Setup (Underline)
      _set_cursor() { echo -ne "\e[4 q"; }
      precmd_functions+=(_set_cursor)
      _set_cursor

# --- History & Behavior ---
      HISTFILE=~/.zsh_history
      HISTSIZE=1000
      SAVEHIST=1000
      setopt appendhistory share_history autocd
      autoload -Uz compinit && compinit -i

# --- Aliases: Navigation & Loonix Tools ---
      alias b='clear'
      alias bb='cd .. && ls'
      alias c='cd ~/loonix/.config && ls'
      alias s='cd ~/loonix/.config/scripts && ls'     
      alias chypr='code -r ~/loonix/.config/hypr/hyprland.conf'
      alias ccolors='code -r ~/loonix/.config/hypr/colors.conf'
      alias cidle='code -r ~/loonix/.config/hypr/hypridle.conf'
      alias clock='code -r ~/loonix/.config/hypr/hyprlock.conf'
      alias cpaper='code -r ~/loonix/.config/hypr/hyprpaper.conf'
      alias cenv='code -r ~/loonix/.config/hypr/configs/env.conf'
      alias cexec='code -r ~/loonix/.config/hypr/configs/exec.conf'
      alias ckeybinds='code -r ~/loonix/.config/hypr/configs/keybinds.conf'
      alias crules='code -r ~/loonix/.config/hypr/configs/rules.conf'
      alias ckit='code -r ~/loonix/.config/kitty/kitty.conf'
      alias cway='code -r ~/loonix/.config/waybar/config.jsonc'
      alias cwaycss='code -r ~/loonix/.config/waybar/style.css'

# --- Dev Aliases ---
      alias tc='code -r'
      alias l='cd ~/loonix && ls'
      alias lp='cd ~/loonix-player && ls'
      alias ll='cd ~/loonix-login && ls'
      alias lt='cd ~/loonix/tools && ls'
      alias ltlm='cd ~/loonix/tools/login-menu && ls'
      alias ltlg='cd ~/loonix/tools/loonix-gui && ls'
      alias ltll='cd ~/loonix/tools/loonix-login && ls'
      alias czsh='code -r ~/loonix/.config/zshs/.zshrc' # Ganti ke VS Code
      alias rzsh='source ~/.zshrc && echo "🚀 Zsh Config Reloaded!"'
      alias nuke='/home/citz/loonix/.config/scripts/r-all.sh'
      alias nr="nuke && rzsh"
      
      # Git & Wails Ops
      alias gogit='cd ~/loonix && git add . && git commit -m "update" && git push && cd -'
      alias gogitp='cd ~/loonix-player && git add . && git commit -m "update" && git push && cd -'
      alias dev-loonix='cd ~/loonix/tools/loonix-gui && wails dev'
      # Wails Dev dengan NVIDIA fix
      alias wdev='__GLX_VENDOR_LIBRARY_NAME=nvidia GBM_BACKEND=nvidia-drm wails dev'
      alias build-loonix='cd ~/loonix/tools/loonix-gui && wails build'
      alias login-test='WLR_RENDERER=pixman cage -s -- ~/loonix/tools/loonix-login/bin/loonix-login'

# --- Aliases: Package Manager ---
      alias update='sudo pacman -Syu'
      alias spi='sudo pacman -S'
      alias spr='sudo pacman -Rs'
      alias yi='yay -S'
      alias yr='yay -Rs'
      alias edit-pacman='SUDO_EDITOR="code-oss --wait" sudoedit /etc/pacman.conf'
      alias edit-iso-pacman='code-oss ~/loonix-iso-build/pacman.conf'
      alias ls='ls -la --color=auto'

# --- Plugins & Extra ---
      source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
      source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
      eval "$(zoxide init zsh)"

# --- Custom Functions ---
      mkd() { mkdir -p "$@" && cd "$_"; }

# --- Pintu Darurat (ByPass) ---
# Uncomment kalau mau balik ke login TTY biasa
# alias bypass='exit'
# =========================================================
#  END OF CONFIG
# =========================================================