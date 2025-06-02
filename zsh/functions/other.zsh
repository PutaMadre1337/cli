# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function nf() {
  nvim $(fd --type file "$@")
}

function take {
  mkdir -p "$@"
  if [[ "$1" == *\{*\} ]]; then
    cd "$(echo "$1" | cut -d'{' -f1)"
  else
    cd "$(dirname "$1")"
  fi
}

function cloc {
  if [ "$1" != "--help" ]; then
    command cloc --md "$@" | tail -n +4 | mdcat
  else
    command cloc --help
  fi
}
