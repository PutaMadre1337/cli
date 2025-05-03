def nf [file_name: string] {
  fd --type file -X nvim
}

def sf [] {
  fd --type file | fzf --multi --bind 'ctrl-o:execute(nvim {+})' --preview 'bat --style=numbers --color always {}'
}
