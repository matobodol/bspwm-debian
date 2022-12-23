#!/bin/bash
#==============================================================[NETWORK]
source $HOME/.config/bspwm/globalrc
ESSIDLAST=ginkgo
PASSLAST=1sampai10

wifi_connecting() {
network=$(ip link | grep "state UP" | awk '{print $2}' | awk -F: '{print $1}')		#cek wifi koneksi
n=35
i=0
for i in {0..35}
do
	pct=$(( (++i) * 100 / n ))
	echo XXX; echo $pct; echo "$msgs"; echo XXX
	sleep 0.1
	if [[ $i -eq 10 ]]; then 
		iwctl station wlan0 connect "$namawifi" --passphrase "$passwifi" &>/dev/null
		if [[ -z $(ip link | grep "state UP" | awk '{print $2}' | awk -F: '{print $1}') ]]; then
		iwctl station wlan0 connect-hidden "$namawifi" --passphrase "$passwifi" &>/dev/null
		fi
		break
	fi
done | whiptail --title "NETWORK" --gauge "Please wait..." 6 55 0
}

#activate internet
connect_wifi() {
while :; do
network=$(ip link | grep "state UP" | awk '{print $2}' | awk -F: '{print $1}')		#cek wifi koneksi
usbteth=$(ip link | grep "enp0s" | awk '{print $2}' | awk -F: '{print $1}')			#cek usb tethering

if [[ $network == "br10" ]]; then network=''
elif [[ -n $network ]]; then
	iwctl station wlan0 disconnect
	$NOTIFY -i $ICON/info.png -t 2000 "Wifi Disconnected"
	exit
elif [[ -n $usbteth ]]; then
	$NOTIFY -i $ICON/info.png -t 2000 "USB Tethering" "Is Connected"
fi

msg="Tidak ada koneksi internet! Periksa kabel jaringan atau wifi.\nTips: Pilih <Refresh> Jika usb tethering telah disambungkan."
whiptail --title "NETWORK" --yesno "$msg" --no-button "refersh" --yes-button "Atur wifi" 9 70; networkyt=$?
case $networkyt in
	0)
	namawifi=$(whiptail --title "WIFI" --inputbox "Nama wifi : " --cancel-button "Exit" 7 55 $ESSIDLAST 3>&1 1>&2 2>&3); apa=$?
	if [[ $apa -eq 1 ]]; then break; exit; fi
	passwifi=$(whiptail --title "WIFI" --passwordbox "Kata sandi wifi : " --cancel-button "Exit" 7 55 $PASSLAST 3>&1 1>&2 2>&3); apa=$?
	if [[ $apa -eq 1 ]]; then break; exit; fi
	if [[ -n $namawifi ]] || [[ -z $passwifi ]]; then
		msgs="Menghubungkan jaringan..."
		wifi_connecting
		if [[ -n $(ip link | grep "state UP" | awk '{print $2}' | awk -F: '{print $1}') ]]; then
			$NOTIFY -i $ICON/info.png -t 2300 "Wifi Connected" "to $namawifi"
			if [[ "$ESSIDLAST" != "$namawifi" ]]; then
			sed -i "0,/ESSIDLAST=.*/s//ESSIDLAST=$namawifi/" $0
			sed -i "0,/PASSLAST=.*/s//PASSLAST=$passwifi/" $0
			fi
			break; exit
		else
			$NOTIFY -i $ICON/info.png -t 2000 "Wifi Not Connected"
			break; exit
		fi
	fi;;
esac
done
}

connect_wifi
