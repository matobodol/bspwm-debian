#! /bin/bash

source $HOME/.config/bspwm/globalrc

rofi_command="rofi -theme ~/.config/bspwm/launcher/shot/shot.rasi"
savedir=~/Pictures/Screenshots
sec=5

[[ ! -d $savedir ]] && mkdir "$savedir"
notify() {
	$NOTIFY -i "$ICON/shot.png" -t 3000 -r 123 'Screenshot' "$msg"
}

screen=''
area=''
timer=''
options="$timer\n$screen\n$area"

if [[ $1 == 'focus' ]]; then 
	msg='Focus Mode'
	scrot -u ${savedir}/focus.png
	notify
elif [[ $1 == 'pointer' ]]; then
	msg='Include Pointer'
	scrot -p ${savedir}/pointer.png
	notify
else
	msg='Saved in ~/Pictures'
	chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 1)"
	case $chosen in
		$screen)
			sleep 0.1; scrot ${savedir}/%Y-%m-%d.png
			notify
		;;
		$area)
			scrot -s ${savedir}/crop.png
			notify
		;;
		$timer)
			
			for i in {5..1}; do
				$NOTIFY -i "$ICON/shot.png" -t 1100 -r 123 'Screenshot' "in $(echo ${i}second..)"
				sleep 1
			
				if [ $i = 1 ];then
					dunstctl close-all
					sleep 0.1
					scrot ${savedir}/grab-%Y-%m-%d.png
					notify 
				fi
			done
			
		;;
	esac
fi
