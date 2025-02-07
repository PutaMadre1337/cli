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
      --multi --bind 'ctrl-o:execute(nvim {1} +{2})'
}

function qrg() {
  pacman -Q |
  fzf --ansi \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --tmux 70% \
      --delimiter : \
      --border=rounded \
      --header 'C-y - copy name, C-r - yay -Rns' \
      --multi --bind 'ctrl-r:execute-silent(yay -Rns --noconfirm {+})' \
      --multi --bind 'ctrl-y:execute-silent(echo -n {+} | wl-copy)'
}

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
  eza -D -1 --show-symlinks --icons=auto
}
