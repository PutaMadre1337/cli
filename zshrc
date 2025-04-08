# zmodload zsh/zprof

autoload -Uz compinit
autoload -Uz compdef

if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit;
else
    compinit -C;
fi

fastfetch

####################################################################################

# if [ -z "$TMUX" ] && [ "$TERM" = "xterm-kitty" ]; then
#   tmux attach || exec tmux new-session && exit;
# fi

####################################################################################

export EDITOR="nvim"
export PATH="$PATH:/home/username/.local/share/go/bin:/home/username/.local/share/bin"

####################################################################################

HISTFILE=~/.zsh_history
HISTSIZE=999999999999
SAVEHIST=999999999999
setopt SHARE_HISTORY

source ~/.zsh/functions/fzf.zsh
source ~/.zsh/functions/autocmd.zsh
source ~/.zsh/functions/other.zsh
source ~/.zsh/functions/system.zsh
source ~/.zsh/functions/golang.zsh
source ~/.zsh/functions/dots.zsh

source ~/.zsh/private.zsh
source ~/.zsh/fzf.zsh

source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
  bindkey '^P' history-substring-search-up
  bindkey '^N' history-substring-search-down

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/fzf-tab/fzf-tab.zsh
source <(fzf --zsh)

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

bindkey -v
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^U' backward-kill-line
bindkey '^F' forward-char
bindkey '^B' backward-char
bindkey '^K' kill-line
bindkey '^Y' yank

####################################################################################

CACHE_DIR="$HOME/.cache/zsh/completions"
mkdir -p "$CACHE_DIR"

commands_and_caches=(
  "nim --generate-completions zsh:$CACHE_DIR/nim_completions.zsh"
  "kubectl completion zsh:$CACHE_DIR/kubectl_completions.zsh"
  "minikube completion zsh:$CACHE_DIR/minikube_completions.zsh"
  "zoxide init --cmd cd zsh:$CACHE_DIR/zoxide_completions.zsh"
  "starship init zsh:$CACHE_DIR/starship_completions.zsh"
)

for entry in "${commands_and_caches[@]}"; do
  command="${entry%%:*}"
  cache_file="${entry##*:}"
  [ ! -f "$cache_file" ] && eval "$command" > "$cache_file"
done

for entry in "${commands_and_caches[@]}"; do
  cache_file="${entry##*:}"
  source "$cache_file"
done

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
alias yps='yay -Ps'

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

# rust
alias cr='cargo run -q'
alias cn='cargo new --vcs git'

# directory navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias mkd='mkdir -p'
alias srmrf='sudo rm -rf'
alias rmrf='rm -rf'

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

# zprof
