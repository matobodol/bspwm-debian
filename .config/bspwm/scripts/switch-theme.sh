#! /bin/bash
source $HOME/.config/bspwm/globalrc

if [[ $THEME == LIGHT ]]; then
	sed -i '0,/THEME.*/s//THEME=DARK/' $HOME/.config/bspwm/globalrc
else
	sed -i '0,/THEME.*/s//THEME=LIGHT/' $HOME/.config/bspwm/globalrc
fi

sed -i '0,/refresh.*/s//refresh=part_theme/' $HOME/.config/bspwm/scripts/startup.sh
$HOME/.config/bspwm/scripts/startup.sh &&

exit 0


