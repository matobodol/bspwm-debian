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
	accent:			#3B4252;
	background:		#252A34;
	foreground:		#64D1E0;
	bgselected:		@accent;
	fgselected:		#FFFFFF;
}
EOF
cat > $pwm <<EOF
* {
	accent:			#B379F2;
	background:		#3B4252;
	background-light:	#252A34;
	foreground:		#64D1E0;
	fg-selected:		#FFFFFF;
}
EOF
}

case $THEME in
LIGHT)
	sed -i 's/Net\/IconThemeName.*/Net\/IconThemeName "Cobalt"/g' $gtkconf
	sed -i 's/Net\/ThemeName.*/Net\/ThemeName "MonoTheme"/g' $gtkconf

	sed -i '0,/background =.*/s//background = #F0F0F0/' $panelconf
	sed -i '0,/foreground =.*/s//foreground = #363C41/' $panelconf
	sed -i '0,/accent =.*/s//accent = #BDBDBD/' $panelconf

	launcher-light
	;;
DARK)
	sed -i 's/Net\/IconThemeName.*/Net\/IconThemeName "Cobalt-dark"/g' $gtkconf
	sed -i 's/Net\/ThemeName.*/Net\/ThemeName "Nordic-darker"/g' $gtkconf

	sed -i '0,/background =.*/s//background = #252A34/' $panelconf
	sed -i '0,/foreground =.*/s//foreground = #f3f3f3/' $panelconf
	sed -i '0,/accent =.*/s//accent = #3B4252/' $panelconf

	launcher-dark
	;;
esac

##dunst
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



