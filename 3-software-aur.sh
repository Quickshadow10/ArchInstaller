#!/usr/bin/env bash

echo
echo "INSTALLING AUR SOFTWARE"
echo

echo "Please enter username:"
read username

cd ~/

echo "CLONING: YAY"
git clone "https://aur.archlinux.org/yay.git"


PKGS=(

    # UTILITIES -----------------------------------------------------------

    'i3lock-fancy'              # Screen locker
    'timeshift'                 # Backup and Restore
	'handbrake-full'            # Multithreaded video transcoder

    # COMMUNICATIONS ------------------------------------------------------

    'firefox'                   # Firefox Browser

    # THEMES --------------------------------------------------------------

	'web-greeter'                   # Lightdm Greeter
    'shikai-theme'                  # Lightdm Login Theme - https://github.com/TheWisker/Shikai
    'materia-gtk-theme'             # Desktop Theme
    'papirus-icon-theme'            # Desktop Icons
    'capitaine-cursors'             # Cursor Icons
    'autojump'                      # Zsh plugin

    # APPS ----------------------------------------------------------------

    'discord'                       # Chat for gamers
    'spotify'                       # Music

)

cd ~/yay
makepkg -si

# Change default shell
chsh -s $(which zsh)

for PKG in "${PKGS[@]}"; do
    yay -S --noconfirm $PKG
done

echo
echo "Done!"
echo
