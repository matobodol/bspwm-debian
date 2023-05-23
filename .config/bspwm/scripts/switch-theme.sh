#! /bin/bash
source $HOME/.config/bspwm/globalrc

if [[ $THEME == 'LIGHT' ]]; then
	sed -i '0,/THEME.*/s//THEME=DARK/' $HOME/.config/bspwm/globalrc
else
	sed -i '0,/THEME.*/s//THEME=LIGHT/' $HOME/.config/bspwm/globalrc
fi

$HOME/.config/bspwm/scripts/startup.sh part_theme

exit 0


