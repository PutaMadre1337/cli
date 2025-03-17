fastfetch

autoload -Uz compinit
  compinit

####################################################################################

if [ -z "$TMUX" ] && [ "$TERM" = "xterm-kitty" ]; then
  tmux attach || exec tmux new-session && exit;
fi

####################################################################################

export EDITOR="nvim"
export PATH="$PATH:/home/username/.local/share/go/bin:/home/username/.local/share/bin"

####################################################################################

source ~/.zsh/functions/fzf.zsh
source ~/.zsh/functions/autocmd.zsh
source ~/.zsh/functions/other.zsh
source ~/.zsh/functions/system.zsh
source ~/.zsh/functions/golang.zsh
source ~/.zsh/functions/dots.zsh

source ~/.zsh/private.zsh
source ~/.zsh/fzf.zsh

ZSH=/usr/share/oh-my-zsh
source $ZSH/oh-my-zsh.sh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
  bindkey '^P' history-substring-search-up
  bindkey '^N' history-substring-search-down

source ~/.zsh/autovenv/autovenv.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source <(fzf --zsh)
source ~/.zsh/fzf-tab/fzf-tab.zsh

####################################################################################

setopt correct
autoload -z edit-command-line

####################################################################################

zle -N edit-command-line
bindkey "^X" edit-command-line

bindkey -r '^L'
bindkey '^L' delete-char

bindkey '^g' fzf-man-widget
zle -N fzf-man-widget

####################################################################################

eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"
eval "$(nim --generate-completions zsh)"

####################################################################################

# eza
alias l='eza -lh --icons=auto'
alias ls='eza -1 --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias ld='eza -lhD --icons=auto'
alias lt='eza --icons=auto --tree'

# packages
alias dw='yay -S --noconfirm'
alias rns='yay -Rns --noconfirm'
alias yc='yay -Yc --noconfirm'
alias r='yay -R --noconfirm'
alias rd='yay -Rd --nodeps'
alias scc='yay -Scc'
alias ps='yay -Ps'

# nvim
alias n='nvim'
alias se='sudoedit'
alias nh='fd ~/.config/hypr | fzf'
alias nz='nvim ~/.zshrc'
alias nt='nvim ~/.tmux.conf && tmux source-file ~/.tmux.conf'

# git
alias lg='lazygit'
alias of='onefetch'

# python
alias mkv='python3 -m venv .venv'
alias rmv='rm -rf .venv'
alias freeze='pip freeze > requirements.txt'

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
alias lr='lazydocker'
alias ten='trans en:ru -e bing'
alias tru='trans ru:en -e bing'
alias ff='fastfetch'
alias t='touch'
alias si='sudo -i'
alias s='sudo'
alias siy='sudo -i yazi $(pwd)'
alias x='chmod +x'
alias sx='sudo chmod +x'
