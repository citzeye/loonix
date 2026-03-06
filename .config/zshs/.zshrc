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
      export PATH="$HOME/.local/bin:$PATH"

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


# --- Dev Aliases ---
      alias czsh='code -r ~/loonix/.config/zshs/.zshrc' # Ganti ke VS Code
      alias rzsh='source ~/.zshrc && echo "🚀 Zsh Config Reloaded!"'
      alias nuke='/home/citz/loonix/.config/scripts/r-all.sh'
      alias nr="nuke && rzsh"
      alias tc='code -r'
      alias lr-rollback='git fetch origin && git reset --hard origin/main'

      # loonix
      alias l='cd ~/loonix && ls'
      alias ggl='cd ~/loonix && git add . && git commit -m "update" && git push && cd -'
      alias lp='cd ~/loonix-player && ls'
      alias ll='cd ~/loonix-login && ls'
      alias ltlm='cd ~/loonix/tools/login-menu && ls'
      alias ltlg='cd ~/loonix/tools/loonix-gui && ls'
      alias ltll='cd ~/loonix/tools/loonix-login && ls'

      # loonix-rust & loonix-tunes dev bind
      alias lr='cd /home/citz/loonix-rust && ls'
      alias lt='cd /home/citz/loonix-rust/loonix-tunes && ls'
      alias ltr='cargo watch -x run' # Preview UI doang tanpa jalanin logic Rust
      alias gglr='cd ~/loonix-rust && git add . && git commit -m "update" && git push && cd -'

      # loonix-waybar-dual
      alias cway='code -r ~/loonix/.config/waybar/config.jsonc'
      alias cwaycss='code -r ~/loonix/.config/waybar/style.css'
      alias gglwd='cd ~/loonix && git add . && git commit -m "update" && git push && cd -'

      # ==================================
      # 🤖 OLLAMA AI & AGENT ALIASES
      # ==================================

      # Path Configuration
      export OLLAMA_MODELS="/usr/share/ollama/.ollama/models"
      export LOONIX_AGENT_PATH="/home/citz/loonix-rust/loonix-agent.py"

      # --- SERVER CORE ---
      ai-start() {
      sudo systemctl stop ollama 2>/dev/null
      sudo pkill -f ollama 2>/dev/null
      echo "Starting Ollama in CPU Mode..."
      # Pakai sudo langsung di depan perintah serve
      sudo CUDA_VISIBLE_DEVICES="" OLLAMA_MODELS="$OLLAMA_MODELS" OLLAMA_HOST="127.0.0.1:11434" ollama serve
      }

      # GOOGLE API KEY      
      export GOOGLE_API_KEY='AIzaSyDgIcADgsdloMWS_t_oeRGvw7T2KOQlfi8'


      # # --- AGENT TOOLS ---
      # ai-fix() {
      # if [[ -f "$1" ]]; then
      #       # Jika input file: Alirkan isi file pakai cat
      #       cat "$1" | CUDA_VISIBLE_DEVICES="" python3 "$LOONIX_AGENT_PATH"
      # else
      #       # Jika input teks: Alirkan teksnya pakai echo
      #       echo "$*" | CUDA_VISIBLE_DEVICES="" python3 "$LOONIX_AGENT_PATH"
      # fi
      # }

      # cara pakai
      # ai-fix src/main.rs
      # atau
      # ai-fix "Jelaskan kenapa error ini muncul: [paste error lu di sini]"

      # --- QUICK ALIASES ---
      alias ai-code="ollama run deepseek-coder:6.7b"
      alias ai-coder="ollama run codellama:7b"
      alias ai-chat="ollama run llama3.2:3b"
      alias ai-smart="ollama run mistral:7b"
      alias ai-list="ollama list"
      alias ai-stop="sudo pkill -f ollama && echo 'Ollama stopped.'"
# ================================== echo 'Ollama stopped.'"

      # ==================================
      
# --- Aliases: Package Manager ---
      alias update='sudo pacman -Syu'
      alias si='sudo pacman -S'
      alias spi='/home/citz/loonix-rust/target/release/loonix-pkg install'
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

# ---  opencode  --- 
export PATH=/home/citz/.opencode/bin:$PATH

# --- Pintu Darurat (ByPass) ---
# Uncomment kalau mau balik ke login TTY biasa
# alias bypass='exit'
# =========================================================
#  END OF CONFIG
# =========================================================