fastfetch
eval "$(zoxide init --cmd cd zsh)"

####################################################################################

export EDITOR="nvim"
export PATH="$PATH:/home/username/.local/share/go/bin"
# tammy
export TREE_ENUMERATOR="rounded"
export RELATIVE_PATH="true"
export DEFAULT_FORM="tree"

####################################################################################

ZSH=/usr/share/oh-my-zsh/
source $ZSH/oh-my-zsh.sh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/fzf-tab/fzf-tab.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
  bindkey '^P' history-substring-search-up
  bindkey '^N' history-substring-search-down

source ~/.zsh/fzf.zsh
source ~/.zsh/functions.zsh
source <(fzf --zsh)

source ~/.zsh/starship.zsh
source ~/.zsh/zoxide.zsh

####################################################################################

setopt correct

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
alias nf='nvim ~/.config/fish/'
alias nfc='nvim ~/.zshrc'

# git
alias lg='lazygit'
alias of='onefetch'

# go
alias gmt='go mod tidy'
alias grm='go run $(find . -iname main.go)'
alias gb='go build $(find . -iname main.go)'

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
alias te='trans en:ru -e bing'
alias tr='trans ru:en -e bing'
alias ff='fastfetch'
alias f='fish'
alias t='touch'
alias si='sudo -i'
alias s='sudo'
alias siy='sudo -i yazi $(pwd)'
alias x='chmod +x'
alias sx='sudo chmod +x'
alias tm='tammy'
# alias countlines='pwd && echo "Общее количество строк: $(cat $(fd -t file) | wc -l)"'
# alias countlines='start_time=$(date +%s.%N); pwd && echo "Общее количество строк: $(cat $(fd -t file) | wc -l)"; end_time=$(date +%s.%N); elapsed_time=$(echo "scale=3; ($end_time - $start_time) * 1000" | bc); echo "Время выполнения: $elapsed_time миллисекунд"'
