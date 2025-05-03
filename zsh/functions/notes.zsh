function note {
  fd --type file . --extension md ~/Documents/Notes | fzf --preview 'mdcat {}' --multi --bind 'ctrl-o:execute(nvim {+})'
}
