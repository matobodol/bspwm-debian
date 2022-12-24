# MY BSPWM SETUP
<img src="/img/light1.png" alt="light1" width="400"/> <img src="/img/light2.png" alt="light2" width="400"/>
<img src="/img/dark1.png" alt="dark1" width="400"/> <img src="/img/dark2.png" alt="dark2" width="400"/>

### X11 minimal
```bash
xserver-xorg-core x11-xserver-utils x11-xkb-utils x11-utils xinit xserver-xorg-video-intel xserver-xorg-input-libinput 
```

### Dependensi
```bash
bspwm sxhkd rofi polybar dunst conky rxvt-unicode scrot i3lock feh neofetch imagemagick w3m xsettingsd cmus xdotool libnotify-bin libglib2.0-dev alsa-utils pulseaudio pulseaudio-utils xdg-user-dirs lxpolkit tar ranger thunar gvfs
```

### Optional
```bash
firefox-esr geany vim mpv htop
```
### Network
* install iwd
```bash
sudo apt install iwd
```
* disable services conflict
```bash
systemctl stop NetworkManager
```
```bash
systemctl disable --now NetworkManager
```
```bash
systemctl disable --now wpa_supplicant
```
* enable iwd service
```bash
systemctl enable --now iwd
```
```bash
systemctl restart iwd
```
* configure iwd
```bash
sudo cat > /etc/iwd/main.conf <<EOF
[General]
EnableNetworkConfiguration=true

[Network]
NameResolvingService=systemd
EOF
```
Replace /etc/rosolv.conf
nameserver 8.8.8.8

### Compositor
* **Picom** **[yshui/picom: A lightweight compositor for X11 - GitHub](https://github.com/yshui/picom)**

### **Installation**
* **clone bspwm-debian dotfile**
```bash
cd ~/Download && git clone https://github.com/matobodol/bspwm-debian
```
* **uncompress icons**
```bash
cd bspwm-debian/.icons && tar -Jxvf icons.tar.xz ; rm -f icons.tar.xz
```
* **uncompress themes**
```bash
cd ../.themes && tar -Jxvf themes.tar.xz ; rm -f themes.tar.xz
```
* **uncompress fonts**
```bash
cd ../.fonts && tar -Jxvf fonts.tar.xz ; rm -f fonts.tar.xz
```
* **copy dotfile to home directory**
```bash
cd .. && cp -rf . $HOME
```
* **refresh cache fonts**
```bash
fc-cache -rv
```

## Tap to click
```bash
sudo cat > /etc/X11/xorg.conf.d/30-touchpad.conf <<EOF
Section "InputClass"
        Identifier "touchpad"
        MatchIsTouchpad "on"
        Driver "libinput"
        Option "Tapping" "on"
        Option "NaturalScrolling" "on"
        Option "ScrollMethod" "twofinger"
EndSection
EOF
```

## Keybind
| Key                                                                | Action                                  |
| ------------------------------------------------------------------ | --------------------------------------- |
| super + a                                                          | Switch to light/dark theme (Toggle)     |
| super + shift + Return                                             | Rofi app launcher                       |
| super + {Return,u}                                                 | Open terminal urxvt                     |
| super + shift + {z,x}                                              | Windows {Close,kill}                    |
| super + :arrow_up: :arrow_down: :arrow_left: :arrow_right:         | Move window floating                    |
| super + alt + :arrow_up: :arrow_down: :arrow_left: :arrow_right:   | Resize windows floating                 |
| super + alt + {h,j,k,l}                                            | Resize windows tiling                   |
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



