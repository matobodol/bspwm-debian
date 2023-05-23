#! /bin/bash

exe="$1"
source $HOME/.config/bspwm/globalrc

part_theme() {
	local FILE_XSETTINGSD=$HOME/.config/bspwm/theme/xsettingsd.conf
	local FILE_PANEL=$HOME/.config/bspwm/panel/config.ini

	local screen=$(xdpyinfo | awk '$1=="dimensions:" {print $2}')
	if [[ $SCREEN != '$screen' ]]; then
		sed -i "s/SCREEN.*/SCREEN=$screen/" $HOME/.config/bspwm/globalrc
	fi

	# app menu
	launcher_light() {
	cat > $HOME/.config/bspwm/launcher/color-scheme.rasi <<EOF
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

	# app menu
	launcher_dark() {
	cat > $HOME/.config/bspwm/launcher/color-scheme.rasi <<EOF
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

	gtk_theme(){
		sed -i "s/Net\/ThemeName.*/Net\/ThemeName \"$gtkTheme\"/g" $FILE_XSETTINGSD
		sed -i "s/Net\/IconThemeName.*/Net\/IconThemeName \"$iconTheme\"/g" $FILE_XSETTINGSD
		sed -i "s/Gtk\/CursorThemeName.*/Gtk\/CursorThemeName \"$cursorTheme\"/g" $FILE_XSETTINGSD
		sed -i "s/Inherits.*/Inherits=$cursorTheme/g" $HOME/.icons/default/index.theme
	}

	case $THEME in
		LIGHT)
			sed -i "0,/accent =.*/s//accent = $light/" $FILE_PANEL
			sed -i "0,/background =.*/s//background = $white/" $FILE_PANEL
			sed -i "0,/foreground =.*/s//foreground = $panelForgroundLight/" $FILE_PANEL
			sed -i "0,/fglight =.*/s//fglight = $red/" $FILE_PANEL
	
			sed -i "0,/color2.*/s//color2 = \'$conkyForgroundLight\'\,/" $HOME/.config/bspwm/conky/kidung_wingit
			
			gtk_theme
			launcher_light
		;;
		DARK)
			sed -i "0,/accent =.*/s//accent = $dark/" $FILE_PANEL
			sed -i "0,/fglight =.*/s//fglight = $cyan/" $FILE_PANEL
			sed -i "0,/background =.*/s//background = $black/" $FILE_PANEL
			sed -i "0,/foreground =.*/s//foreground = $panelForgroundDark/" $FILE_PANEL
	
			sed -i "0,/color2.*/s//color2 = \'$conkyForgroundDark\'\,/" $HOME/.config/bspwm/conky/kidung_wingit
			
			gtk_theme
			launcher_dark
		;;
	esac
}

case $exe in
	part_theme)
	
		part_theme
		bspc wm -r
		
	;;
	no)
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
esac

exit 0
