#!/bin/bash
source $HOME/.config/bspwm/globalrc
killall dunst &>/dev/null

case $THEME in
LIGHT)
	dunst -config ~/.config/dunst/dunstrc-light
	;;
DARK)
	dunst -config ~/.config/dunst/dunstrc-dark
	;;
esac

