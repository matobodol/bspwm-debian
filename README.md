# MY BSPWM SETUP
<img src="/img/light1.png" alt="light1" width="400"/> <img src="/img/light2.png" alt="light2" width="400"/>
<img src="/img/dark1.png" alt="dark1" width="400"/> <img src="/img/dark2.png" alt="dark2" width="400"/>

### **X11 minimal**
```bash
xserver-xorg-core x11-xserver-utils x11-xkb-utils x11-utils xinit xserver-xorg-video-intel xserver-xorg-input-libinput 
```

### **Dependensi**
```bash
bspwm sxhkd rofi polybar dunst conky rxvt-unicode scrot i3lock feh neofetch imagemagick w3m xsettingsd cmus xdotool libnotify-bin libglib2.0-dev alsa-utils pulseaudio pulseaudio-utils xdg-user-dirs lxpolkit tar ranger
```

### **Optional**
```bash
firefox-esr geany vim mpv htop thunar gvfs
```

### **Compositor**
**Picom** **[yshui/picom: A lightweight compositor for X11 - GitHub](https://github.com/yshui/picom)**

### **Installation**
> **clone bspwm-debian dotfile**
```bash
cd ~/Download && git clone https://github.com/matobodol/bspwm-debian
```
> **uncompress icons**
```bash
cd bspwm-debian/.icons && tar -Jxvf icon.tar.xz ; rm -f icon.tar.xz
```
> **uncompress themes**
```bash
cd ../.themes && tar -Jxvf theme.tar.xz ; rm -f theme.tar.xz
```
> **uncompress fonts**
```bash
cd ../.fonts && tar -Jxvf font.tar.xz ; rm -f font.tar.xz
```
> **copy dotfile to home directory**
```bash
cd .. && cp -rf . $HOME
```
> **refresh cache fonts**
```bash
fc-cache -rv
```

## **Tap to click**
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

## **Keybind**
| Key                                                                     | Action                                  |
| ----------------------------------------------------------------------- | --------------------------------------- |
| <kbd>super + a                                                          | Switch to light/dark theme (Toggle)     |
| <kbd>super + shift + Return                                             | Rofi app launcher                       |
| <kbd>super + {Return,u}                                                 | Open terminal urxvt                     |
| <kbd>super + shift + {z,x}                                              | Windows {Close,kill}                    |
| <kbd>super + :arrow_up: :arrow_down: :arrow_left: :arrow_right:         | Move window floating                    |
| <kbd>super + alt + :arrow_up: :arrow_down: :arrow_left: :arrow_right:   | Resize windows floating                 |
| <kbd>super + alt + {h,j,k,l}                                            | Resize windows tiling                   |
| <kbd>super + {h,j,k,l}                                                  | Change node focus                       |
| <kbd>super + shift + {h,j,k,l}                                          | Move active windows                     |
| <kbd>super + shift + Space                                              | Scratchpad: hide window                 |
| <kbd>super + space                                                      | Scratchpad: show window                 |
| <kbd>super + {1,2,3,4,5,}                                               | Swap workspace                          |
| <kbd>super + shift + {1,2,3,4,5,}                                       | Move active windows to workspace        |
| <kbd>super + z                                                          | Musik player cmus                       |
| <kbd>super + {equal,minus}                                              | Focus the next/previous window          |
| <kbd>super + shift + {equal,minus}                                      | Focus the older or newer node           |
| <kbd>super + XF86MonBrightness{Up,Down}                                 | Set brightness                          |
| <kbd>super + XF86Audio{RaiseVolume,LowerVolume,Mute}                    | Set audio volume                        |
| <kbd>super + shift + {s,b}                                              | Open config {sxhkdrc,bspwmrc}           |
| <kbd>super + Delete                                                     | Lock screen                             |
| <kbd>super + shift + Delete                                             | Power menu                              |
| <kbd>super + alt + {r,q}                                                | WM {Restart,Quit}                       |



