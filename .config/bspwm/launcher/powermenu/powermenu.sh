#!/usr/bin/env bash

# Load Global Variable
source $HOME/.config/bspwm/globalrc
rofi_command="rofi -theme ~/.config/bspwm/launcher/powermenu/powermenu.rasi"

# Options
shutdown=""
reboot=""
lock=""
suspend=""
logout=""

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"
chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 2)"

case $chosen in
    $shutdown) eval Shutdown ;;
    $reboot) eval Reboot ;;
    $lock) eval Lock ;;
    $suspend) eval Sleep ;;
    $logout) eval Logout ;;
esac
