source ~/.config/bspwm/globalrc

case $1 in
	i)
	iface=$(iwctl device list | awk '$5=="station" {print $1}' | head -n 1)
	iface_powered=$(iwctl device list | grep "$iface" | awk '{print $3}')
	state=$(iwctl station $iface show | awk '$1=="State" {print $2}')
	run_state=$(pgrep -l iwd.sh | head -n1 | awk '{print $2}')
		
	if [[ $run_state == 'iwd.sh' ]]; then
		pkill iwd.sh; exit 0
		elif [[ $iface_powered == 'off' ]]; then
			$NOTIFY -i $ICON/info.png -t 2000 -r 123 "Wifi Powered is OFF" ; exit 0
			elif [[ $state == 'connected' ]]; then
				iwctl station $iface disconnect
				$NOTIFY -i $ICON/info.png -t 2000 -r 123 "Wifi Disconnected"
	else 
		urxvt -name iwd -e ~/.config/bspwm/scripts/iwd.sh 0 ;
	fi ;;
	n)
	 ~/.config/bspwm/scripts/iwd.sh 1 ;;
esac &&

exit 0
