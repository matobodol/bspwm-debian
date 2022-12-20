# MY BSPWM SETUP

## X11 minimal
```bash
xserver-xorg-core x11-xserver-utils x11-xkb-utils x11-utils xinit xserver-xorg-video-intel xserver-xorg-input-libinput 
```

## Dependensi
```bash
bspwm sxhkd rofi polybar dunst conky rxvt-unicode scrot i3lock feh htop neofetch imagemagick w3m xsettingsd cmus xdotool libnotify-bin libglib2.0-dev alsa-utils pulseaudio pulseaudio-utils xdg-user-dirs lxpolkit gvfs tar thunar
```

> **Compositor** **[yshui/picom: A lightweight compositor for X11 - GitHub](https://github.com/yshui/picom)**

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

| Key                                                                   | Action                                  |
| --------------------------------------------------------------------- | --------------------------------------- |
| <kbd>Mod + Shift + Return                                             | App launcher (rofi)                     |
| <kbd>Mod + {Return,u}                                                 | Open terminal (urxvt)                   |
| <kbd>Mod + shift + {z,x}                                              | {Close,kill} Windows                    |
| <kbd>Mod + :arrow_up: :arrow_down: :arrow_left: :arrow_right:         | Move window floating                    |
| <kbd>Mod + alt + :arrow_up: :arrow_down: :arrow_left: :arrow_right:   | Resize Windows floating                 |
| <kbd>Mod + alt + {h,j,k,l}                                            | Resize Windows tiling                   |
| <kbd>Mod + {h,j,k,l}                                                  | swap node focus                         |
| <kbd>Mod + shift + {h,j,k,l}                                          | Move active windows                     |
| <kbd>Mod + Shift + Space                                              | Scratchpad: hide (like i3wm)            |
| <kbd>Mod + Space                                                      | Scratchpad: show (like i3wm)            |
| <kbd>Mod + 1/2/3/4/5/6/7/8/9                                          | Swap Workspace                          |
| <kbd>Mod + Shift + 1/2/3/4/5/6/7/8/9                                  | Move active windows to workspace        |
| <kbd>Mod + z                                                          | run cmus musik player                   |
| <kbd>Mod + a                                                          | Switch theme light/dark (Toggle)        |
| <kbd>Mod + {equal,minus}                                              | Focus the next/previous window          |
| <kbd>Mod + shift + {equal,minus}                                      | Focus the older or newer node           |
| <kbd>Mod + XF86MonBrightness{Up,Down}                                 | Set brightness                          |
| <kbd>Mod + XF86Audio{RaiseVolume,LowerVolume,Mute}                    | Set audio volume                        |
| <kbd>Mod + shift + {s,b}                                              | Open config {sxhkdrc,bspwmrc}           |
| <kbd>Mod + Del                                                        | Lock Screen                             |
| <kbd>Mod + Shift + Del                                                | Power Menu                              |
| <kbd>Mod + alt + {r,q}                                                | WM {Restart,Quit}                       |



