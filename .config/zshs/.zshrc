# =========================================================
#  ZSH CONFIGURATION (LOONIX MASTER)
# =========================================================

# Force Zsh if we are in VS Code and not already in Zsh
if [[ "$TERM_PROGRAM" == "vscode" ]] && [[ "$SHELL" != "/usr/bin/zsh" ]]; then
    export SHELL=/usr/bin/zsh
    exec /usr/bin/zsh -l
fi

# --- Loonix Boot Sequence ---
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  # 1. Jalankan Loonix-Login di dalam Cage
  cage ~/loonix/tools/loonix-login/bin/loonix-login

  # 2. Begitu Cage ditutup (User sukses login), tembak pake UWSM
  if uwsm check may-start; then
      exec uwsm start hyprland.desktop
  else
      # Fallback kalau uwsm bermasalah, biar gak nyangkut di TTY
      exec Hyprland
  fi
fi

# --- 1. Environment Variables ---
export EDITOR='micro'
export VISUAL='micro'
export QT_QPA_PLATFORMTHEME=qt5ct #paksa aplikasi QT pakai gaya GTK
# Fix untuk AGS dan aplikasi GTK
export XDG_RUNTIME_DIR=/run/user/$UID
export PATH="$HOME/.config/scripts:$HOME/.config/locals/bin:$PATH"

# --- 2. Simple Prompt Setup ---
#PROMPT='%F{cyan}%n@%m%f >
#'

# Not simple prompt
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

# --- Cursor Setup (Underline) ---
_set_cursor() { echo -ne "\e[4 q"; }
precmd_functions+=(_set_cursor)
_set_cursor

# --- 3. History & Behavior ---
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
setopt share_history
setopt autocd

# --- 4. Completion ---
autoload -Uz compinit
compinit -i

# --- 5. Aliases: Navigation ---
alias ,='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias c='cd ~/loonix/.config'
alias l='cd ~/loonix'
alias ltlg='cd ~/loonix/tools/loonix-gui'
alias ltll='cd ~/loonix/tools/loonix-login'
alias s='cd ~/loonix/.config/scripts'
alias t='cd ~/loonix/tools'
#alias z='cd'


# --- 6. Aliases: Hyprland Configs (Target: Loonix Folder) ---
alias chypr='micro ~/loonix/.config/hypr/hyprland.conf'
alias ccolors='micro ~/loonix/.config/hypr/colors.conf'
alias cidle='micro ~/loonix/.config/hypr/hypridle.conf'
alias clock='micro ~/loonix/.config/hypr/hyprlock.conf'
alias cpaper='micro ~/loonix/.config/hypr/hyprpaper.conf'
alias cenv='micro ~/loonix/.config/hypr/configs/env.conf'
alias cexec='micro ~/loonix/.config/hypr/configs/exec.conf'
alias ckeybinds='micro ~/loonix/.config/hypr/configs/keybinds.conf'
alias crules='micro ~/loonix/.config/hypr/configs/rules.conf'
	# HYPRPANEL ALIASES ---
	#alias cpanel='micro ~/loonix/.config/hyprpanel/config.json'
	#alias copanel='micro ~/loonix/.config/hyprpanel/options.json'

# --- 7. Aliases: Apps & Shell ---
alias ckit='micro ~/loonix/.config/kitty/kitty.conf'
alias cway='micro ~/loonix/.config/waybar/config.jsonc'
alias cwaycss='micro ~/loonix/.config/waybar/style.css'
alias czsh='micro ~/loonix/.config/zshs/.zshrc'
alias rzsh='source ~/.zshrc && echo "🚀 Zsh Config Reloaded!"'
alias nuke='/home/citz/loonix/.config/scripts/r-all.sh'
# Super alias fushion refresh total
alias nz="nuke && rzsh"

alias gogit='cd ~/loonix && git add . && git commit -m "update" && git push && cd -'

# --- 8. Aliases: Package Manager ---
alias update='sudo pacman -Syu'
alias spi='sudo pacman -S'
alias spr='sudo pacman -Rs'
alias yi='yay -S'
alias yr='yay -Rs'
alias ls='ls -la --color=auto'
alias la='ls -a'

# --- 9. Custom Functions ---
mkd() { mkdir -p "$@" && cd "$_"; }

# --- 10. Plugins (Arch Linux Path) ---
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# --- 11. ByPass Login ---
# --- Auto Start Hyprland dari TTY1 ---
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  exec Hyprland
fi
# =========================================================
eval "$(zoxide init zsh)"
#  END OF CONFIG
# =========================================================
