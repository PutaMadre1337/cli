# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Fzf
function rf() {
  rg --color=always --line-number --no-heading --smart-case "${*:-}" |
  fzf --ansi \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --delimiter : \
      --tmux 70% \
      --info=inline \
      --preview 'bat --color=always {1} --highlight-line {2}' \
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
      --border=rounded \
      --header 'C-o - open file in nvim' \
      --multi --bind 'ctrl-o:execute(nvim {+})'
}

function note() {
  fd -t file . ~/Documents/ |
    fzf --ansi \
        --preview 'mdcat {1}' \
        --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
        --multi --bind 'ctrl-o:execute(nvim {+})' \
        --bind 'ctrl-e:execute(nvim ~/Documents/"${*:-}".md)' \
}

function in() {
    yay -Slq | fzf -q "$1" -m --preview 'yay -Si {1}'| xargs -ro yay -S --noconfirm
}

function re() {
    yay -Qq | fzf -q "$1" -m --preview 'yay -Qi {1}' | xargs -ro yay -Rns
}

fzf-man-widget() {
  manpage="echo {} | sed 's/\([[:alnum:][:punct:]]*\) (\([[:alnum:]]*\)).*/\2 \1/'"
  batman="${manpage} | xargs -r man | col -bx | bat --language=man --plain --color always --theme=\"Monokai Extended\""
   man -k . | sort \
   | awk -v cyan=$(tput setaf 6) -v blue=$(tput setaf 4) -v res=$(tput sgr0) -v bld=$(tput bold) '{ $1=cyan bld $1; $2=res blue $2; } 1' \
   | fzf  \
      -q "$1" \
      --ansi \
      --tiebreak=begin \
      --prompt=' Man > '  \
      --preview-window '50%,rounded,<50(up,85%,border-bottom)' \
      --preview "${batman}" \
      --bind "enter:execute(${manpage} | xargs -r man)" \
      --bind "alt-c:+change-preview(cht.sh {1})+change-prompt(ﯽ Cheat > )" \
      --bind "alt-m:+change-preview(${batman})+change-prompt( Man > )" \
      --bind "alt-t:+change-preview(tldr {1})+change-prompt(ﳁ TLDR > )"
  zle reset-prompt
}
bindkey '^g' fzf-man-widget
zle -N fzf-man-widget

# Golang
function gmi {
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

# cd autocmd
function chpwd {
  eza -D -1 --show-symlinks --icons=auto -l
}

# Other
function benchmark() {
    local cmd="$@"
    local start_time=$(($(date +%s%N)/1000000))
    eval "$cmd"
    local exit_code=$?
    local end_time=$(($(date +%s%N)/1000000))
    local duration=$(( end_time - start_time ))
    local duration_ms=$(echo "scale=3; $duration / 1000" | bc)
    echo "Command: $cmd"
    echo "Duration: $duration_ms seconds"
    if [ $exit_code -ne 0 ]; then
        echo "Exit code: $exit_code"
    fi
}

