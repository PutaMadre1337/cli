def fdnote [] {
  fd --type file . --extension md ~/Documents/Notes
  | fzf --preview 'mdcat {} | fold -sw (tput cols)' --multi --bind 'ctrl-o:execute(nvim {+})'
}
