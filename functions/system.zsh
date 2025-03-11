function up {
  trap 'pkill -RTMIN+20 waybar' EXIT
  yay -Syu --noconfirm
  yay -Yc --noconfirm
}
