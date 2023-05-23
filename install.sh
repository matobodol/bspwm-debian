#!/bin/bash
# Setup Bspwm On Debian Netinst Fresh Install


## setup bspwm
#~ install dotfiles
info_msg() {
if [[ $? -ne 0 ]]; then
	echo "setup gagal."
	exit 0
fi
}

install_dotfiles(){
	# membuat hirarki user direktory
	xdg-user-dirs-update
	
	# copy dotfile ke home direktory
	cp -rf {.config,.fonts,.icons,.themes/} $HOME/
	info_msg
	
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
	PACKAGES+='sudo '
	# x11 minimal
	PACKAGES+='xserver-xorg-core xserver-xorg-input-libinput xserver-xorg-video-intel x11-xserver-utils x11-xkb-utils x11-utils xinit '
	# core
	PACKAGES+='bspwm sxhkd rofi polybar dunst conky xterm scrot i3lock feh imagemagick w3m xsettingsd xdotool libnotify-bin libglib2.0-dev alsa-utils pulseaudio pulseaudio-utils lxpolkit '
	# utilitas
	PACKAGES+='thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman ffmpegthumbnailer tumbler w3m cmus'
	
	sudo apt install -y ${PACKAGES}
	info_msg
}

## setup network with iwd (iwctl)
#~ mematikan network
if_down(){
	interfaceName=$(sudo iw dev | awk '/Interface/ {print $2}')
	sudo ifdown $interfaceName
	info_msg
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
	
	info_msg
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
	info_msg
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

info_msg
}

## install picom
install_picom(){
	
	# install builder
	sudo apt install -y build-essential
	
	# dependensi picom
	sudo apt install -y libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson
	
	# download picom
	git clone https://github.com/yshui/picom.git && cd picom
	git submodule update --init --recursive
	
	# compile picom
	meson setup --buildtype=release . build
	ninja -C build
	ninja -C build install
	info_msg
}

case $1 in
	set_install)
		install_dotfiles
		install_packages
		if_down
		setup_iwd
		connect_to_wifi
		
		if [[ $? -eq 0 ]]; then
			clear
			echo "alias wm='startx /usr/bin/bspwm'" >> $HOME/.bashrc
			echo "install dotfiles selesai. Mohon relogin kemudian"
			echo "untuk masuk ke bspwm ketik: wm"
		fi
	;;
	set_picom)
		install_picom
		if [[ $? -eq 0 ]]; then
			clear
			echo "install selesai. Restart bspwm untuk menerapkan efek"
		fi
	;;
	set_touchpad)
		tap_to_click
		if [[ $? -eq 0 ]]; then
			clear
			echo "setup touchpad gagal."
		fi
	;;
	*)
		echo -e "set_install\t: Untuk install dotfiles"
		echo -e "set_picom\t: Untuk install picom"
		echo -e "set_touchpad\t: Untuk mengaktifkan 'tap to click'\n\n"
		echo "contoh: ./install.sh set_install"
	;;
esac









