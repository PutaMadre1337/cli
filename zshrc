fastfetch
eval "$(zoxide init --cmd cd zsh)"

export EDITOR="nvim"
export PATH="$PATH:/home/username/.local/share/go/bin"

ZSH=/usr/share/oh-my-zsh/

# tammy
export TREE_ENUMERATOR="rounded"
export RELATIVE_PATH="true"
export DEFAULT_FORM="tree"

source $ZSH/oh-my-zsh.sh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/fzf-tab/fzf-tab.zsh
source ~/.zsh/zsh-fzf-history-search/zsh-fzf-history-search.zsh
source ~/.zsh/fzf.zsh
source ~/.zsh/functions.zsh
source <(fzf --zsh)

source ~/.zsh/starship.zsh
source ~/.zsh/zoxide.zsh

setopt correct

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
alias gmi='go mod init'
alias grm='go run $(find . -iname main.go)'
alias gb='go build $(find . -iname main.go)'

function gmit {
if [ -z "$1" ]; then
    go mod init default
    go mod tidy
    return
  fi
    go mod init "$1"
    go mod tidy
}
function newgo {
if [ -z "$1" ]; then
    return 1
  fi

  mkdir "$1"
  cd "$1" || return 1

  mkdir -p cmd/"$1"
  mkdir internal
  echo -e "package main\n\nfunc main() {\n}" > cmd/"$1"/main.go

  go mod init "$1"
  go mod tidy

  git init
  git add .
  git commit -m "initial commit"
  git branch dev
  git checkout -b master
  git checkout dev
  git merge master

  echo "Go project '$1' created successfully."
}
function gbo {
    go build -o "$@" $(find . -iname main.go)
}


# directory navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias mkd='mkdir -p'
alias srm='sudo rm -rf'
alias rm='rm -rf'

function chpwd {
  pwd
  eza -D -1 --show-symlinks --icons=auto
}

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
alias countlines='pwd && echo "Общее количество строк: $(cat $(fd -t file) | wc -l)"'
# alias countlines='start_time=$(date +%s.%N); pwd && echo "Общее количество строк: $(cat $(fd -t file) | wc -l)"; end_time=$(date +%s.%N); elapsed_time=$(echo "scale=3; ($end_time - $start_time) * 1000" | bc); echo "Время выполнения: $elapsed_time миллисекунд"'
