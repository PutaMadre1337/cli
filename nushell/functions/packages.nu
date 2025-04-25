def re [] {
    yay -Qq | fzf -m --preview 'yay -Qi {1}' --tmux 80% | xargs -ro yay -Rns
}

def in [] {
    yay -Slq | fzf -m --preview 'yay -Si {1}' --tmux 80% | xargs -ro yay -S --noconfirm
}

def packages [] {
    expac --timefmt='%F %T' '%n %v %l' | lines | split column " " | select column3 column1 column2 | rename installed package version
}

