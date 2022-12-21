#! /bin/bash

source $HOME/.config/bspwm/globalrc

gtkconf=$HOME/.config/bspwm/theme/xsettingsd.conf
panelconf=$HOME/.config/bspwm/panel/config.ini
launcher=$HOME/.config/bspwm/launcher/colors.rasi
pwm=$HOME/.config/bspwm/launcher/powermenu/color-bar.rasi

screen=$(xdpyinfo | awk '$1=="dimensions:" {print $2}')
if [[ $SCREEN != '$screen' ]]; then
	sed -i "s/SCREEN.*/SCREEN=$screen/" ~/.config/bspwm/globalrc
fi

launcher-light() {
cat > $launcher <<EOF
* {
	accent:			#B379F2;
	background:		#F3F3F3;
	foreground:		#363C41;
	bgselected:		#FF80C3;
	fgselected:		#FFFFFF;
}
EOF
cat > $pwm <<EOF
* {
	accent:			#B379F2;
	background:		#F9F9F9;
	background-light:	#F0F0F0;
	foreground:		#FF80C3;
	fg-selected:		#FFFFFF;
}
EOF
}

launcher-dark() {
cat > $launcher <<EOF
* {
	accent:			#363C41;
	background:		#15191F;
	foreground:		#64D1E0;
	bgselected:		#B379F2;
	fgselected:		#FFFFFF;
}
EOF
cat > $pwm <<EOF
* {
	accent:			#B379F2;
	background:		#363C41;
	background-light:	#15191F;
	foreground:		#64D1E0;
	fg-selected:		#FFFFFF;
}
EOF
}

case $THEME in
LIGHT)
	sed -i 's/Net\/IconThemeName.*/Net\/IconThemeName "Cobalt"/g' $gtkconf
	sed -i 's/Net\/ThemeName.*/Net\/ThemeName "Qogir-Light"/g' $gtkconf

	sed -i '0,/background =.*/s//background = #f3f3f3/' $panelconf
	sed -i '0,/foreground =.*/s//foreground = #363C41/' $panelconf
	sed -i '0,/accent =.*/s//accent = #BDBDBD/' $panelconf

	launcher-light
	;;
DARK)
	sed -i 's/Net\/IconThemeName.*/Net\/IconThemeName "Cobalt-dark"/g' $gtkconf
	sed -i 's/Net\/ThemeName.*/Net\/ThemeName "Qogir-Dark"/g' $gtkconf

	sed -i '0,/background =.*/s//background = #15191f/' $panelconf
	sed -i '0,/foreground =.*/s//foreground = #f3f3f3/' $panelconf
	sed -i '0,/accent =.*/s//accent = #363C41/' $panelconf

	launcher-dark
	;;
esac

# dunst
$HOME/.config/dunst/dunst.sh &

# wallpaper
feh --bg-scale --no-fehbg ~/.config/bspwm/theme/wallpaper/${THEME}.png

# theme
xsettingsd -c $HOME/.config/bspwm/theme/xsettingsd.conf &

# xrdb
xrdb -merge $HOME/.config/bspwm/theme/${THEME}/.Xresources

# polybar
$HOME/.config/bspwm/panel/panel.sh &

# set brightness & volume
brightnessctl set $BRIGHTNESS
amixer set Master $VOLUME

# conky
$HOME/.config/bspwm/conky/start_kidung_wingit &

# theme notify
$NOTIFY -i $ICON/theme.png -t 2300 -r 123 "$THEME THEME" "Vol: $VOLUME | Bright: $BRIGHTNESS"



