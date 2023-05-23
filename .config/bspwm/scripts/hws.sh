source $HOME/.config/bspwm/globalrc

volume_notify() {
local volume=$(amixer | grep 'Right: Playback' | awk -F'[][]' '{print $2}')
local mute=$(amixer | grep 'Right: Playback' | awk ' {print $6}' | awk -F'[][]' '{print $2}')
local img

if [[ ${volume::-1} -eq 0 ]];then
	img=volume-muted.png
elif [[ ${volume::-1} -le 10 ]];then
	img=volume-low.png
elif [[ ${volume::-1} -le 30 ]];then
	img=volume-medium.png
elif [[ ${volume::-1} -ge 30 ]];then
	img=volume-high.png
fi

if [[ $mute == off ]];then
	$NOTIFY -i $ICON/volume-muted.png -t 1500 -r 123 "Volume Is Mute" "$volume"
else
	$NOTIFY -i $ICON/$img -t 1500 -r 123 "Volume  $volume"
fi
sed -i "0,/VOLUME.*/s//VOLUME=$volume/" ~/.config/bspwm/globalrc
}


brightness_notify() {
local brightness=$(brightnessctl i | grep % | awk -F'[)(]' '{print $2}')
local img

if [[ ${brightness::-1} -le 10 ]];then
	img=brightness-off.png
elif [[ ${brightness::-1} -le 30 ]];then
	img=brightness-low.png
elif [[ ${brightness::-1} -le 50 ]];then
	img=brightness-medium.png
elif [[ ${brightness::-1} -le 70 ]];then
	img=brightness-high.png
elif [[ ${brightness::-1} -le 100 ]];then
	img=brightness-full.png
fi

$NOTIFY -i $ICON/$img -t 1500 -r 123 "Brightness  $brightness"
sed -i "0,/BRIGHTNESS.*/s//BRIGHTNESS=$brightness/" ~/.config/bspwm/globalrc
}

case $1 in
mute)
	pactl set-sink-mute 0 toggle
	volume_notify
	;;
vol-up)
	amixer set 'Master' 2%+
	volume_notify
	;;
vol-down)
	amixer set 'Master' 2%-
	volume_notify
	;;
bright-up)
	brightnessctl set 2%+
	brightness_notify
	;;
bright-down)
	brightnessctl set 2%-
	brightness_notify
	;;
esac &&

exit 0
