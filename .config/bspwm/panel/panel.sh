#! /bin/bash

setup_screen() {
	local window_gap=$(cat .config/bspwm/bspwmrc | awk '$3=="window_gap" {print $4}')
	local screen_width=$(xdpyinfo | grep dimensions: | awk '{print $2}' | awk -F'x' '{print $1}')

	local offset=$((screen_width - window_gap * 2))

	local n=$(cat ~/.config/bspwm/panel/config.ini | awk '$1=="width" {print $3}')
	local nxy=$(cat ~/.config/bspwm/panel/config.ini | awk '$1=="offset-x" {print $3}')

	if [[ "$offset" != "$n" ]] || [[ "$window_gap" != "$nxy" ]]; then
		sed -i "27s/width.*/width = $offset/" $HOME/.config/bspwm/panel/config.ini
		sed -i "s/offset-x.*/offset-x = $window_gap/" $HOME/.config/bspwm/panel/config.ini
		sed -i "s/offset-y.*/offset-y = $window_gap/" $HOME/.config/bspwm/panel/config.ini
	fi
}

start_bar() {
	pkill polybar
	polybar -c ~/.config/bspwm/panel/config.ini debian
	
	exit 0
}

setup_screen
start_bar
