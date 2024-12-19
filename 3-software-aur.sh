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

    # COMMUNICATIONS ------------------------------------------------------

    'brave-bin'                 # Brave

    # THEMES --------------------------------------------------------------

    'lightdm-webkit-theme-aether'   # Lightdm Login Theme - https://github.com/NoiSek/Aether#installation
    'materia-gtk-theme'             # Desktop Theme
    'papirus-icon-theme'            # Desktop Icons
    'capitaine-cursors'             # Cursor Icons
    'autojump'                      # Zsh plugin

    # APPS ----------------------------------------------------------------

    'discord'                       # Chat for gamers
    'youtubemusic-nativefier'        # Music

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