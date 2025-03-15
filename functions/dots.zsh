function hypr() {
  fd --no-ignore-vcs . ~/.config/hypr -t f |\
    rg -vi "/assets/|license" |\
    rg -i "\.conf$|\.sh$|\.py$" |\
    fzf --preview 'if [ -d {} ]; then eza --tree {}; else bat --style=numbers --color=always --line-range :500 {}; fi'\
    --preview-window=right:30%:wrap --height 40% --border rounded \
    --bind 'ctrl-o:execute(nvim {})+abort' \
    --bind 'ctrl-m:execute(nvim {})+abort'
}
