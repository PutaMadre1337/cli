def up [] {
  ^pkill -RTMIN+20 waybar
  ^yay -Syu --noconfirm
  ^yay -Yc --noconfirm
}
