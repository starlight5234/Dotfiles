# Dotfiles

## **Requirements:**

- \*NIX system
- [bspwm](https://wiki.archlinux.org/index.php/Bspwm)
- [sxhkd](https://wiki.archlinux.org/index.php/Sxhkd)
- [picom-ibhagwan](https://aur.archlinux.org/packages/picom-ibhagwan-git/)
- required programs:
	- dunst (Notifcations daemon)
	- rofi (Applications window launcher)
	- polybar (Top bar)
	- numlockx (Num lock on startup)
	- xbacklight (Control screen brightness)
	- picom-ibhagwan (Rounded corners, compositer)
	- flameshot (For taking screenshots)
	- spectacle (Alternative for flameshot cuz my lappy sucks :v)
	- thunar ( File Manager)

* Fonts:

> - [JetBrains Mono](https://www.jetbrains.com/lp/mono/)
> - [Fira Code Nerd](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode)

## Customizations

### keyboard shortcuts

Shortcuts are controlled by sxhkd, since there are no default applications handler you can set your default apps from sxhkdrc

#### default keyboard shortcuts

| key                        | function                                                   |
| -------------------------- | ---------------------------------------------------------- |
| win key(mod/super) + space | Launch rofi                                                |
| super + alt + b            | Launch browser (default is firefox)                        |
| super + Enter              | Launch terminal (default is konsole)                       |
| super + alt + f            | Launch file manager (default is thunar)                    |
| super + Escape             | Reload sxhkd settings                                      |
| super + w                  | Kill current window                                        |
| super + g                  | Swap current window with the biggest                       |
| super + t                  | Set window to tiled                                        |
| super + f                  | Set window to floating                                     |
| super + shift + t          | Set window to pseudo tiled                                 |
| super + alt + {j,k,i,l}    | Focus the window on left, below, above, right respectively |
| super + Tab                | Focus last desktop                                         |
| super + shift + 1-9        | Move window to desktop number 1-9                          |
| super + alt + {Down,Right} | Expand window on given side                                |
| ctrl + alt + {Left,Up}     | Contract window on inverse of given side                   |
| super + direction          | Move floating window on given direction                    |
| ctrl + print               | Take a full screenshot                                     |
| print + shift              | Launch flameshot area selection                            |
| super + alt + t            | Launch telegram                                            |

#### Auto lockscreen on wake

- copy betterlockscreen@.service to /etc/systemd/system
- run `sudo systemctl enable simplelock@$USER`

#### Screenshots

#### Home
![Workspace](/home.png)

#### Firefox ( Default Browser with Material Ocean theme )
![Firefox Browser](/firefox.png)

#### Special Thanks to

- [@Blacksuan19](https://github.com/blacksuan19) for his Dots as an inspiration and base.
- [@nckmml](https://github.com/nckmml) for the volume control to avoid speakers from tearing.
- Every package dev who made those packages
