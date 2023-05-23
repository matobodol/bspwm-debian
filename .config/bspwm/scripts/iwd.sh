#! /bin/bash
source ~/.config/bspwm/globalrc

iface=$(iwctl device list | awk '$5=="station" {print $1}' | head -n 1)
state=$(iwctl station $iface show | awk '$1=="State" {print $2}')

ESSID='abc'
PASS='1sampai15'
forget=

if [[ -n $forget ]]; then
	unset ESSID
	unset PASS
fi

switch() {
	[[ $ESSID != $namawifi ]] && sed -i "0,/ESSID=.*/s//ESSID=\'$namawifi\'/" $0
	[[ $PASS != $passwifi ]] && sed -i "0,/PASS=.*/s//PASS=\'$passwifi\'/" $0
	[[ -n $forget ]] && sed -i "0,/forget.*/s//forget=/" $0
}

notify() {
	iwctl station $iface connect "$namawifi" --passphrase "$passwifi" &>/dev/null
	
	if [[ $? == 0 ]]; then
		$NOTIFY -i $ICON/info.png -t 2300 -r 123 "Wifi Connected" "to $namawifi"
		switch
	else
		iwctl station $iface connect-hidden "$namawifi" --passphrase "$passwifi" &>/dev/null
		if [[ $? == 0 ]]; then
			$NOTIFY -i $ICON/info.png -t 2300 -r 123 "Wifi: Connected" "to $namawifi"
			switch
		else
		  $NOTIFY -i $ICON/info.png -t 2300 -r 1234 "Wifi: Unable" "to connect"
		fi
	fi
}

wifi_connecting() {
	local n=50
	for i in {1..50}; do
		local pct=$(( i * 100 / n ))
		echo XXX; echo $pct; echo "Menghubungkan..."; echo XXX
		
		if [[ $i -eq 1 ]]; then
			iwctl station $iface scan
		elif [[ $i -eq $(($n - 5 )) ]]; then
			notify
		fi
		
		sleep 0.01
done | whiptail --title "NETWORK" --gauge "Please wait..." 6 55 0
}

input_box() {
	
	local namawifi=$(whiptail --title "WIFI" --inputbox "Nama wifi: " --cancel-button "Exit" 7 55 "$ESSID" 3>&1 1>&2 2>&3)
	case $? in 1 | 255) exit; esac
	
	local passwifi=$(whiptail --title "WIFI" --passwordbox "Kata sandi wifi: " --cancel-button "Exit" 7 55 "$PASS" 3>&1 1>&2 2>&3)
	case $? in 1 | 255) exit; esac
	
	wifi_connecting
}

case $1 in
	0)
		input_box
	;;
	1)
		if [[ $state -eq 'connecting' ]] || [[ $state -eq 'connected' ]]; then
			iwctl station $iface disconnect
			
			if [[ $? -eq 0 ]]; then
				$NOTIFY -i $ICON/info.png -t 2300 -r 123 "Wifi is Disconnected"
			fi
			
		fi
	;;
esac

exit 0
