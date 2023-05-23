#!/bin/bash
# Setup Bspwm On Debian Netinst Fresh Install


## setup bspwm
#~ install dotfiles
info_msg() {
if [[ $? -ne 0 ]]; then
	clear
	local msg=$1
	echo "$msg"
	exit 0
fi
}

install_dotfiles(){
	# membuat hirarki user direktory
	xdg-user-dirs-update
	info_msg 'xdg-user-dirs-update, gagal'
	
	# copy dotfile ke home direktory
	cp -rf {.config,.fonts,.icons,.themes/} $HOME/
	info_msg 'copying dotfiles ke direktori home gagal.'
	# extrak fonts
	cd $HOME/.fonts && tar -Jxvf fonts.tar.xz
	info_msg 'Ekstrak fonts.tar.xz gagal'
	rm fonts.tar.xz
	info_msg 'Membersihkan archive fonts gagal.'
	
	# ekstrak icons
	cd $HOME/.icons
	tar -Jxvf icons.tar.xz
	info_msg 'Ekstrak icons.tar.xz gagal'
	tar -Jxvf cursor.tar.xz
	info_msg 'Ekstrak cursor.tar.xz gagal'
	rm icons.tar.xz cursor.tar.xz
	info_msg 'Membersihkan archive fonts icons dan cursor gagal.'

	# ekstak themes
	cd $HOME/.themes && tar -Jxvf themes.tar.xz
	info_msg 'Ekstrak themes.tar.xz gagal'
	rm themes.tar.xz && cd ..
	info_msg 'Membersihkan archive themes gagal.'
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
	info_msg 'install_packages gagal'
}

## setup network with iwd (iwctl)
setup_iwd(){
	clear
	# menddapatkan nama interface
	local interfaceName=$(sudo iw dev | awk '/Interface/ {print $2}')
	
	# memutuskan sambungan wpa_supplicant
	if_down(){
		sudo ifdown $interfaceName
		info_msg 'Memutuskan sambungan wpa_supplicant, gagal.'
	}
	if_down
	
	# mengatur layanan iwd
	setup_iwd_service(){
		# install iwd
		sudo apt install -y iwd

		# membuat configurasi iwd
		if ! [[ -f /etc/iwd/main.conf ]]; then
			echo -e "[General]\nEnableNetworkConfiguration=true" | sudo tee /etc/iwd/main.conf
		fi
	
		# menonaktifkan layanan wpa_supplicant
		sudo systemctl stop wpa_supplicant.service
		sudo systemctl disable --now wpa_supplicant.service
	
		# mengaktifkan layanan iwd
		sudo systemctl enable --now iwd.service
		sudo systemctl start iwd.service
	}
	setup_iwd_service
	
	# menghubungkan ke wifi
	connecting(){
		local SSID PSK status

		# user input
		read -p "Nama Wifi: " SSID
		echo -e "Kosongkan jika wifi tidak dipassword\n dengan langsung tekan Enter"
		read -p "Password: " PSK
	
		# menghubungkan ke ssid terbuka
		iwctl station ${interfaceName} connect "${SSID}" --passphrase "${PSK}" &>/dev/null
		# jika gagal, menghubungkan ke ssid tersembunyi
		[[ $? -ne 0 ]] && iwctl station ${interfaceName} connect-hidden "${SSID}" --passphrase "${PSK}" &>/dev/null
		# notif jika sersambung ke jaringan wifi
		[[ $? -eq 0 ]] && echo "Terhubung ke jaringan ${insterfaceName}"
	}
	# cek layanan iwd actif
	local status_service=$(systemctl status iwd.service | awk '/Active: / {print $2}')
	local status_connect=$(iwctl station wlan0 show | awk '/State/ (print $2)')
	connecting

	mengulang jika belum terhubung ke wifi
	while true; do
	# mengakhiri loop jika status iwctl connected
	if [[ $status_connect -eq 'connected' ]]; then
		break
	# jika layanan iwd aktif tetapi tidak terhubung ke wifi
	elif [[ $status_service -eq 'active' ]] && [[ $status_connect -ne 'connected' ]]; then
		connecting
	# jika layanan iwd belum aktif
	else
		setup_iwd_service
		connecting
	fi
	done
}

## touchpad driver
tap_to_click() {
if ! [[ -f  /etc/X11/xorg.conf.d/30-touchpad.conf ]]; then
cat <<EOF | sudo tee > /etc/X11/xorg.conf.d/30-touchpad.conf
Section "InputClass"
	Identifier "touchpad"
	MatchIsTouchpad "on"
	Driver "libinput"
	Option "Tapping" "on"
	Option "NaturalScrolling" "on"
	Option "ScrollMethod" "twofinger"
EndSection
EOF
	
	info_msg 'setup tap_to_click gagal.'
fi
}

## install picom
install_picom(){
	# install builder
	sudo apt install -y build-essential
	info_msg 'install build-essential, gagal'

	# install dependensi picom
	local PACKAGES=''
	PACKAGES+='libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson '
	PACKAGES+='libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-glx0-dev libpixman-1-dev libxcb-render0-dev '
	PACKAGES+='libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev '
	sudo apt install -y ${PACKAGES}
	info_msg 'install dependensi picom, gagal'
	
	# download picom
	if [[ -d picom ]]; then
		rm -rf picom
		info_msg 'membersihkan folder usang picom gagal'
	else
		git clone https://github.com/yshui/picom.git && cd picom
		info_msg 'git clone https://github.com/yshui/picom.git, gagal.'
		git submodule update --init --recursive
		
		# compile picom
		meson setup --buildtype=release . build
		info_msg 'meson setup --buildtype=release . build, gagal'
		ninja -C build
		info_msg 'ninja -C build, gagal'
		ninja -C build install
		info_msg 'ninja -C build install, gagal'
	fi
}

option=(\
'setup_bspwm' ': Untuk install dotfiles'\ 
'setup_picom' ': Untuk install compositor picom'\ 
'setup_touchpad  ' ': Untuk mengaktifkan tap to click'\
)
menu=$(whiptail --menu 'Pilih Menu : ' --title 'Setup Bspwm On Debian' 12 80 0 "${option[@]}" 3>&1 1>&2 2>&3)

case $menu in
	setup_bspwm)
		install_dotfiles
		install_packages
		setup_iwd
		
		if [[ $? -eq 0 ]]; then
			if ! [[ $(sed -n "/alias wm='startx \/usr\/bin\/bspwm'/p" $HOME/.bashrc) ]]; then
				echo "alias wm='startx /usr/bin/bspwm'" >> $HOME/.bashrc
			fi
			
			clear
			echo "install dotfiles selesai. Mohon relogin kemudian"
			echo "untuk masuk ke bspwm ketik: wm"
			sudo systemctl restart iwd.services
		fi
	;;
	setup_picom)
		install_picom
		if [[ $? -eq 0 ]]; then
			clear
			echo "install selesai. Restart bspwm untuk menerapkan efek"
		fi
	;;
	setup_touchpad*)
		tap_to_click
		if [[ $? -eq 0 ]]; then
			clear
			echo "setup touchpad selesai."
		fi
	;;
esac










