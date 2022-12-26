#! /bin/bash

source $HOME/.config/bspwm/globalrc
refresh=always

part_theme() {
gtkconf=$HOME/.config/bspwm/theme/xsettingsd.conf
panelconf=$HOME/.config/bspwm/panel/config.ini
cursorconf=$HOME/.icons/default/index.theme
launcher=$HOME/.config/bspwm/launcher/color-scheme.rasi
pwm=$HOME/.config/bspwm/launcher/powermenu/color-bar.rasi

screen=$(xdpyinfo | awk '$1=="dimensions:" {print $2}')
if [[ $SCREEN != '$screen' ]]; then
	sed -i "s/SCREEN.*/SCREEN=$screen/" ~/.config/bspwm/globalrc
fi

launcher-light() {
# app menu
cat > $launcher <<EOF
* {
	accent:			$magenta;
	bg-mainbox:		$magenta;
	background:		$white;
	background-light:	$light;
	bgselected:		$red;
	foreground:		$black;
	foreground-light:	$red;
	fgselected:		$white;
}
EOF
}

launcher-dark() {
# app menu
cat > $launcher <<EOF
* {
	accent:			$magenta;
	bg-mainbox:		$dark;
	background:		$black;
	background-light:	$dark;
	bgselected:		$dark;
	foreground:		$cyan;
	foreground-light:	$cyan;
	fgselected:		$white;
}
EOF
}

case $THEME in
LIGHT)
	sed -i "s/Net\/ThemeName.*/Net\/ThemeName \"MonoTheme\"/g" $gtkconf
	sed -i "s/Net\/IconThemeName.*/Net\/IconThemeName \"Cobalt\"/g" $gtkconf
	sed -i "s/Gtk\/CursorThemeName.*/Gtk\/CursorThemeName \"Bibata-Modern-Classic\"/g" $gtkconf
	sed -i "s/Inherits.*/Inherits=Bibata-Modern-Classic/g" $cursorconf
	
	sed -i "0,/accent =.*/s//accent = $light/" $panelconf
	sed -i "0,/background =.*/s//background = $white/" $panelconf
	sed -i "0,/foreground =.*/s//foreground = #99A0AD/" $panelconf
	sed -i "0,/fglight =.*/s//fglight = $red/" $panelconf
	
	sed -i "0,/color2.*/s//color2 = \'#F8FF00\'\,/" $HOME/.config/bspwm/conky/kidung_wingit

	launcher-light
	;;
DARK)
	sed -i "s/Net\/ThemeName.*/Net\/ThemeName \"Nordic-darker\"/g" $gtkconf
	sed -i "s/Net\/IconThemeName.*/Net\/IconThemeName \"Cobalt-dark\"/g" $gtkconf
	sed -i "s/Gtk\/CursorThemeName.*/Gtk\/CursorThemeName \"Bibata-Modern-Ice\"/g" $gtkconf
	sed -i "s/Inherits.*/Inherits=Bibata-Modern-Ice/g" $cursorconf

	sed -i "0,/accent =.*/s//accent = $dark/" $panelconf
	sed -i "0,/fglight =.*/s//fglight = #64D1E0/" $panelconf
	sed -i "0,/background =.*/s//background = $black/" $panelconf
	sed -i "0,/foreground =.*/s//foreground = #99A0AD/" $panelconf
	
	sed -i "0,/color2.*/s//color2 = \'#2be3fc\'\,/" $HOME/.config/bspwm/conky/kidung_wingit
	
	launcher-dark
	;;
esac
}

always() {
	# set gtk theme
	xsettingsd -c $HOME/.config/bspwm/theme/xsettingsd.conf &
	# polybar
	$HOME/.config/bspwm/panel/panel.sh &
	# conky
	$HOME/.config/bspwm/conky/start_kidung_wingit &
	# dunst
	$HOME/.config/dunst/dunst.sh &
	# wallpaper
	feh --bg-scale --no-fehbg ~/.config/bspwm/theme/wallpaper/${THEME}.png
	# xrdb
	xrdb -merge $HOME/.config/bspwm/theme/${THEME}/.Xresources
}

if [[ -z $(pgrep -l picom) ]] ; then refresh=always; fi
case $refresh in
part_theme)
	part_theme
	bspc wm -r 
	;;
always)
	always
		
	# picom
	[[ -z $(pgrep -l picom) ]] && picom -b &
	# autenthic
	[[ -z $(pgrep -l lxpolkit) ]] && lxpolkit &

	# set brightness & volume
	brightnessctl set $BRIGHTNESS
	amixer set Master $VOLUME
	# theme notify
	$NOTIFY -i $ICON/theme.png -t 2300 -r 123 "$THEME THEME" "Vol: $VOLUME | Bright: $BRIGHTNESS"
	;;
esac &&

exit 0
