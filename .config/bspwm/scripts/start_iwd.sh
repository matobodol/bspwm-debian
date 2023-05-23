source ~/.config/bspwm/globalrc

pilihan_i() {
	local iface=$(iwctl device list | awk '$5=="station" {print $1}' | head -n 1)
	local iface_powered=$(iwctl device list | grep "$iface" | awk '{print $3}')
	local state=$(iwctl station $iface show | awk '$1=="State" {print $2}')
	local run_state=$(pgrep -l iwd.sh | head -n1 | awk '{print $2}')
	
	if [[ $run_state == 'on' ]]; then
		exit 0
	elif [[ $iface_powered == 'off' ]]; then
		$NOTIFY -i $ICON/info.png -t 2000 -r 123 "Wifi Powered is OFF" ; exit 0
	elif [[ $state == 'connected' ]]; then
		$NOTIFY -i $ICON/info.png -t 2000 -r 123 "Wifi is Connected"
	else
		if [[ -n $(pgrep -l iwd.sh) ]];then
			pkill iwd.sh
		else
			xterm -class 'iwdmenu' -e ~/.config/bspwm/scripts/iwd.sh 0 ;
		fi
	fi	
}

case $1 in
	i)
		pilihan_i
  ;;
	n)
	 ~/.config/bspwm/scripts/iwd.sh 1
  ;;
esac 

exit 0
