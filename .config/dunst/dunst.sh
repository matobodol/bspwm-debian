#!/bin/bash
source $HOME/.config/bspwm/globalrc


case $THEME in
LIGHT)
	pkill -f dunstrc-dark
	dunst -config ~/.config/dunst/dunstrc-light
	;;
DARK)
	pkill -f dunstrc-light
	dunst -config ~/.config/dunst/dunstrc-dark
	;;
esac

