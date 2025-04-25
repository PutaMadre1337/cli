fastfetch

source ~/.cache/carapace/init.nu

source ~/.config/nushell/app/zoxide.nu
let zoxide_completer = {|spans|
    $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
}

alias cd = __zoxide_z
alias cdi = zi

def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

# packages
alias dw =  yay -S --noconfirm
alias rns = yay -Rns --noconfirm
alias yc = yay -Yc --noconfirm
alias r = yay -R --noconfirm
alias rd = yay -Rd --nodeps
alias scc = yay -Scc
alias yps = yay -Ps

# nvim
alias n = nvim
alias se = sudoedit
alias nh = fd ~/.config/hypr | fzf
alias nz = nvim ~/.zshrc

# git
alias lg = lazygit
alias of = onefetch

# python
alias mkv = python3 -m venv .venv
alias rmv = rm -rf .venv
alias freeze = pip freeze > requirements.txt

# go
alias gmt = go mod tidy
alias grm = go run (ls **/* | rg main.go | awk '{print $4}')
alias gb = go build (ls **/* | rg main.go | awk '{print $4}')

# rust
alias cr = cargo run -q
alias cn = cargo new --vcs git

# directory navigation shortcuts
alias wstop = sudo waydroid session stop and sudo waydroid container stop
alias mkd = mkdir
alias srmrf = sudo rm -rf
alias rmrf = rm -rf

# other
alias hf = hyperfine
alias wstop = sudo waydroid session stop and sudo waydroid container stop
alias lr = lazydocker
alias ten = trans en:ru -e bing
alias tru = trans ru:en -e bing
alias ff = fastfetch
alias t = touch
alias si = sudo -i
alias s = sudo
alias siy = sudo -i yazi (pwd)
alias x = chmod +x
alias sx = sudo chmod +x
alias icat = kitty +icat
alias c = clear

# let functions = ls ~/.config/nushell/functions | get name | to text
# for function in $functions {
#   source $function
# }

source ~/.config/nushell/functions/system.nu
source ~/.config/nushell/functions/docker.nu
source ~/.config/nushell/functions/packages.nu
