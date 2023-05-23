# Setup Bspwm di Debian Netinst Fresh Install

> * Screenshot
<img src="/img/light1.png" alt="light1" width="400"/> <img src="/img/light2.png" alt="light2" width="400"/>
<img src="/img/dark1.png" alt="dark1" width="400"/> <img src="/img/dark2.png" alt="dark2" width="400"/></br></br>

# Menghubungkan Ke Wifi
> * melihat nama interface
```bash
# iw dev | awk '/Interface/ {print$2}'
# ip link set $interface up
```
> * edit file /etc/network/interfaces dan tambahkan baris dibawah: </br>
!Note: Jangan lupa sesuaikan nama_interface, nama_wifi, dan pasword_wifi
```bash
allow-hotplug nama_interface
iface nama_interface inet dhcp
	wpa-ssid nama_wifi
	wpa-psk password_wifi
	wpa-scan-ssid 1
```
> * aktifkan koneksi
```bash
# ifup nama_interface
```
</br></br>

# Instal Menggunakan Script
> * **clone bspwm-debian dotfile**
```bash
git clone https://github.com/matobodol/bspwm-debian.git && cd bspwm-debian
```
> * **jalankan script installer**
```bash
./install.sh
```
<br/><br/>

# Instal Manual
## X11 minimal
> * saya merkomendasikan menginstall paket 'xorg' daripada X11 minimal. <br>
!Note: jangan lupa sesuaikan dengan kartu vidoe milik anda. Disini saya menggunakan video intel
```bash
xserver-xorg-core xserver-xorg-video-intel xserver-xorg-input-libinput x11-utils x11-xkb-utils x11-xserver-utils xinit
```
</br></br>

## Membutuhkan
> * core
```bash
bspwm sxhkd rofi polybar dunst conky xterm scrot i3lock feh imagemagick w3m xsettingsd xdotool libnotify-bin libglib2.0-dev alsa-utils pulseaudio pulseaudio-utils lxpolkit
```
> * utilitas
```bash
thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman ffmpegthumbnailer tumbler w3m cmus
```
> * aplikasi cli (optional)
```bash
mpv neovim htop neofetch qt5ct qt5-style-plugins xclip thermald
```
> * aplikasi gui (optional)
```bash
firefox-esr geany parole viwenior lxappearance nitrogen xfce4-power-manager 
```
</br></br>

## Network Manager iwd
> * install iwd
```bash
sudo apt install iwd
```
> * nonaktifkan layanan wpa_supplicant
```bash
systemctl disable --now wpa_supplicant
```
> * aktifkan layanan iwd.service
```bash
systemctl enable --now iwd.service
systemctl restart iwd.service
```
> * configure iwd
```bash
echo -e "[General]\nEnableNetworkConfiguration=true" | sudo tee -a /etc/iwd/main.conf
```
</br></br>

## Compositor (optional)
* **Picom** **[yshui/picom: A lightweight compositor for X11 - GitHub](https://github.com/yshui/picom)**</br></br></br>

# CARA INSTALL
> * **clone bspwm-debian dotfile**
```bash
git clone https://github.com/matobodol/bspwm-debian.git && cd bspwm-debian
```
> * **uncompress icons**
```bash
cd .icons && tar -Jxvf icons.tar.xz
tar -Jxvf cursor.tar.xz
rm *.tar.xz
```
> * **uncompress themes**
```bash
cd ../.themes && tar -Jxvf themes.tar.xz ; rm themes.tar.xz
```
> * **uncompress fonts**
```bash
cd ../.fonts && tar -Jxvf fonts.tar.xz ; rm fonts.tar.xz
```
> * **Hapus folder .git dan file README.md**
```bash
rm -rf .git README.md
```
> * **copy dotfile ke home directory**
```bash
cd .. && cp -rf . $HOME
```
> * **refresh cache fonts**
```bash
fc-cache -rv
```
</br></br>

## Aktifkan tap to click pada touchpad
> add to /etc/X11/xorg.conf.d/30-touchpad.conf
```bash
Section "InputClass"
	Identifier "touchpad"
	MatchIsTouchpad "on"
	Driver "libinput"
	Option "Tapping" "on"
	Option "NaturalScrolling" "on"
	Option "ScrollMethod" "twofinger"
EndSection
```
</br></br>

## Keybind
| Keymaps                                                            | Action                                  |
| ------------------------------------------------------------------ | --------------------------------------- |
| super + a                                                          | Switch to light/dark theme (Toggle)     |
| super + shift + Return                                             | Rofi app launcher                       |
| super + {Return,u}                                                 | Open terminal xterm                     |
| super + shift + {z,x}                                              | Windows {Close,kill}                    |
| super + :arrow_up: :arrow_down: :arrow_left: :arrow_right:         | Move window floating                    |
| super + alt + :arrow_up: :arrow_down: :arrow_left: :arrow_right:   | Resize window floating                  |
| super + alt + {h,j,k,l}                                            | Resize window tiling                    |
| super + {h,j,k,l}                                                  | Change node focus                       |
| super + shift + {h,j,k,l}                                          | Move active windows                     |
| super + shift + Space                                              | Scratchpad: hide window                 |
| super + space                                                      | Scratchpad: show window                 |
| super + {1,2,3,4,5,}                                               | Swap workspace                          |
| super + shift + {1,2,3,4,5,}                                       | Move active windows to workspace        |
| super + z                                                          | Musik player cmus                       |
| super + {equal,minus}                                              | Focus the next/previous window          |
| super + shift + {equal,minus}                                      | Focus the older or newer node           |
| super + XF86MonBrightness{Up,Down}                                 | Set brightness                          |
| super + XF86Audio{RaiseVolume,LowerVolume,Mute}                    | Set audio volume                        |
| super + shift + {s,b}                                              | Open config {sxhkdrc,bspwmrc}           |
| super + Delete                                                     | Lock screen                             |
| {Print,super + Print,super + shift + print}                        | Screenshot: menu,focused,include pointer|
| super + {_,shift + }End                                            | Wifi (iwd) {connnect,forget network}    |
| super + shift + Delete                                             | Power menu                              |
| super + alt + {r,q}                                                | WM {Restart,Quit}                       |




