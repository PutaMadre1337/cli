fastfetch

autoload -Uz compinit
compinit

eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"
eval "$(nim --generate-completions zsh)"

####################################################################################

if [ -z "$TMUX" ] && [ "$TERM" = "xterm-kitty" ]; then
  tmux attach || exec tmux new-session && exit;
fi

####################################################################################

export GTK_USE_PORTAL=1
export EDITOR="nvim"
export PATH="$PATH:/home/username/.local/share/go/bin:/home/username/.local/share/bin"

# tammy
export TREE_ENUMERATOR="rounded"
export RELATIVE_PATH="true"
export DEFAULT_FORM="tree"
alias tm='tammy'

####################################################################################

ZSH=/usr/share/oh-my-zsh
source $ZSH/oh-my-zsh.sh
source ~/.zsh/functions.zsh
source ~/.zsh/system-scripts.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
  bindkey '^P' history-substring-search-up
  bindkey '^N' history-substring-search-down

source ~/.zsh/fzf.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source <(fzf --zsh)
source ~/.zsh/fzf-tab/fzf-tab.zsh

####################################################################################

# export QT_STYLE_OVERRIDE=DarkMaroon
export QT_STYLE_OVERRIDE=kvantum-dark
export QT_QPA_PLATFORMTHEME=qt5ct

####################################################################################

setopt correct
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X" edit-command-line

####################################################################################

# eza
alias l='eza -lh --icons=auto'
alias ls='eza -1 --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias ld='eza -lhD --icons=auto'
alias lt='eza --icons=auto --tree'

# packages
alias dw='yay -S --noconfirm'
alias up='yay -Syu --noconfirm && yay -Yc --noconfirm'
alias rns='yay -Rns --noconfirm'
alias yc='yay -Yc --noconfirm'
alias r='yay -R --noconfirm'
alias rd='yay -Rd --nodeps'
alias scc='yay -Scc'
alias ps='yay -Ps'

# nvim
alias n='nvim'
alias se='sudoedit'
alias nh='nvim ~/.config/hypr/'
alias nfc='nvim ~/.zshrc'
alias nt='nvim ~/.tmux.conf && tmux source-file ~/.tmux.conf'

# git
alias lg='lazygit'
alias of='onefetch'

# go
alias gmt='go mod tidy'
alias grm='go run $(find . -iname main.go)'
alias gb='go build $(find . -iname main.go)'

# Rust
alias cr='cargo run -q'
alias cn='cargo new --vcs git'

# directory navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias mkd='mkdir -p'
alias srm='sudo rm -rf'
alias rm='rm -rf'

# other
alias hf='hyperfine'
alias wstop='sudo waydroid session stop && sudo waydroid container stop'
alias dockerrmall="docker rm -f $(docker ps -a | awk '{ print $1 }') && docker system prune -a -f"
alias lr='lazydocker'
alias te='trans en:ru -e bing'
alias tr='trans ru:en -e bing'
alias ff='fastfetch'
alias t='touch'
alias si='sudo -i'
alias s='sudo'
alias siy='sudo -i yazi $(pwd)'
alias x='chmod +x'
alias sx='sudo chmod +x'
# alias countlines='pwd && echo "Общее количество строк: $(cat $(fd -t file) | wc -l)"'
# alias countlines='start_time=$(date +%s.%N); pwd && echo "Общее количество строк: $(cat $(fd -t file) | wc -l)"; end_time=$(date +%s.%N); elapsed_time=$(echo "scale=3; ($end_time - $start_time) * 1000" | bc); echo "Время выполнения: $elapsed_time миллисекунд"'
