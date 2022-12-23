#! /bin/bash
source ~/.config/bspwm/globalrc

ESSID=
PASS=

iface=$(iwctl device list | awk '$5=="station" {print $1}' | head -n 1)
iface_powered=$(iwctl device list | grep "$iface" | awk '{print $3}')
state=$(iwctl station $iface show | awk '$1=="State" {print $2}')

notify() {
	iwctl station $iface connect "$namawifi" --passphrase "$passwifi" &>/dev/null
	if [[ $? == 0 ]]; then
		$NOTIFY -i $ICON/info.png -t 2300 "Wifi Connected" "to $namawifi"
		if [[ "$ESSID" != "$namawifi" ]]; then
			sed -i "0,/ESSID=.*/s//ESSID=$namawifi/" $0
			sed -i "0,/PASS=.*/s//PASS=$passwifi/" $0
		fi
	else
		iwctl station $iface connect-hidden "$namawifi" --passphrase "$passwifi" &>/dev/null
		[[ $? == 0 ]] && $NOTIFY -i $ICON/info.png -t 2300 "Wifi Connected" "to $namawifi"
	fi
	
}

wifi_connecting() {
network=$(ip link | grep "state UP" | awk '{print $2}' | awk -F: '{print $1}')		#cek wifi koneksi
n=15
for i in {0..15}
do
	pct=$(( i * 100 / n ))
	echo XXX; echo $pct; echo "Menghubungkan..."; echo XXX
	sleep 0.1
	if [[ $i -eq 15 ]]; then 
		notify
		break
	fi
done | whiptail --title "NETWORK" --gauge "Please wait..." 6 55 0
}

input_box() {
	namawifi=$(whiptail --title "WIFI" --inputbox "Nama wifi: " --cancel-button "Exit" 7 55 $ESSID 3>&1 1>&2 2>&3)
	[[ $? -eq 1 ]] && exit
	passwifi=$(whiptail --title "WIFI" --passwordbox "Kata sandi wifi: " --cancel-button "Exit" 7 55 $PASS 3>&1 1>&2 2>&3)
	[[ $? -eq 1 ]] && exit
	wifi_connecting
}

[[ $iface_powered == 'off' ]] && $NOTIFY -i $ICON/info.png -t 2000 "Wifi status is OFF" && exit

case $1 in
0)
	if [[ $state == 'connected' ]]; then
		iwctl station $iface disconnect
		$NOTIFY -i $ICON/info.png -t 2000 "Wifi Disconnected"
	else 
		input_box
	fi ;;
1)
	iwctl known-networks "$ESSID" forget &>/dev/null ;;
esac
