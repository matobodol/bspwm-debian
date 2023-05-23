#!bin/bash
# Setup Bspwm On Debian Netinst Fresh Install


## setup bspwm
#~ install dotfiles
install_dotfiles(){
	# membuat hirarki user direktory
	xdg-user-dirs-update
	
	# copy dotfile ke home direktory
	cp -rf .config/ .fonts/ .icons/ .themes/ $HOME
	
	# extrak fonts
	cd $HOME/.fonts && tar -Jxvf fonts.tar.xz
	rm fonts.tar.xz
	
	# ekstrak icons
	cd $HOME/.icons
	tar -Jxvf icons.tar.xz
	tar -Jxvf cursor.tar.xz
	rm icons.tar.xz cursor.tar.xz

	# ekstak themes
	cd $HOME/.themes && tar -Jxvf themes.tar.xz
	rm themes.tar.xz
}
#~ install packages
install_packages() {
	local PACKAGES=''
	# x11 minimal
	PACKAGES+='sudo apt install xserver-xorg-core xserver-xorg-input-libinput xserver-xorg-video-intel x11-xserver-utils x11-xkb-utils x11-utils xinit '
	# core
	PACKAGES+='bspwm sxhkd rofi polybar dunst conky xterm scrot i3lock feh imagemagick w3m xsettingsd xdotool libnotify-bin libglib2.0-dev alsa-utils pulseaudio pulseaudio-utils lxpolkit '
	# utilitas
	PACKAGES+='thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman ffmpegthumbnailer tumbler w3m cmus'
	
	sudo apt install -y ${PACKAGES}
}

## setup network with iwd (iwctl)
#~ mematikan network
if_down(){
	interfaceName=$(sudo iw dev | awk '/Interface/ {print $2}')
	sudo ifdown $interfaceName
}
#~ configuring iwd
setup_iwd(){
	# embuat configurasi iwd
	echo -e "[General]\nEnableNetworkConfiguration=true" | sudo tee -a /etc/iwd/main.conf
	
	# menonaktifkan layanan wpa_supplicant
	sudo systemctl stop wpa_supplicant.service
	sudo systemctl disable --now wpa_supplicant.service
	
	# mengaktifkan layanan iwd
	sudo systemctl enable --now iwd.service
	sudo systemctl start iwd.service
}
#~ connecting to wifi
connect_to_wifi(){
	local SSID PSK
	
	# user input
	read -p "Nama Wifi: " SSID
	echo -e "Kosongkan jika wifi tidak dipassword\n dengan langsung tekan Enter"
	read -p "Password: " PSK
	
	# menghubungkan ke wifi
	iwctl station ${interfaceName} connect "${SSID}" --passphrase "${PSK}" &>/dev/null
}

## touchpad driver
tap_to_click() {
cat <<EOF | sudo tee -a /etc/X11/xorg.conf.d/30-touchpad.conf
Section "InputClass"
	Identifier "touchpad"
	MatchIsTouchpad "on"
	Driver "libinput"
	Option "Tapping" "on"
	Option "NaturalScrolling" "on"
	Option "ScrollMethod" "twofinger"
EndSection
EOF
}


case $1 in
	install)
		install_dotfiles
		install_packages
		if_down
		setup_iwd
		connect_to_wifi
	;;
	touchpad)
		tap_to_click
	;;
esac

clear
echo "alias wm='startx /usr/bin/bspwm'" >> $HOME/.bashrc
echo "installasi selesai. mohon relogin kemudian"
echo "ketikkan 'wm' untuk masuk ke bspwm"







