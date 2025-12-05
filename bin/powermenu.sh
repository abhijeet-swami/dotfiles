#!/usr/bin/env bash

shutdown="  Shutdown"
reboot="  Reboot"
lock="  Lock"
suspend="  Suspend"

rofi_cmd() {
  rofi -dmenu \
    \
    -theme ~/.config/rofi/powermenu.rasi # -p "Power Menu" \
}

run_rofi() {
  echo -e "$lock\n$suspend\n$reboot\n$shutdown" | rofi_cmd
}

run_cmd() {
  case $1 in
  --shutdown)
    systemctl poweroff
    ;;
  --reboot)
    systemctl reboot
    ;;
  --suspend)
    systemctl suspend
    ;;
  --lock)
    sleep 0.2
    hyprlock
    ;;
  esac
}

chosen="$(run_rofi)"

case $chosen in
$shutdown)
  run_cmd --shutdown
  ;;
$reboot)
  run_cmd --reboot
  ;;
$lock)
  run_cmd --lock
  ;;
$suspend)
  run_cmd --suspend
  ;;
esac
