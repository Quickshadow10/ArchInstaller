#!/usr/bin/env bash

echo
echo "Generating .xinitrc file"
echo

# Generate the .xinitrc file so we can launch Awesome from the
# terminal using the "startx" command
cat <<EOF > ~/.xinitrc
#!/bin/bash
# Disable bell
xset -b

# Disable all Power Saving Stuff
xset -dpms
xset s off

# X Root window color
xsetroot -solid darkgrey
EOF
# ------------------------------------------------------------------------

echo
echo "Updating /bin/startx to use the correct path"

# By default, startx incorrectly looks for the .serverauth file in our HOME folder.
sudo sed -i 's|xserverauthfile=\$HOME/.serverauth.\$\$|xserverauthfile=\$XAUTHORITY|g' /bin/startx

# ------------------------------------------------------------------------

echo
echo "Configuring vconsole.conf to set a larger font for login shell"

sudo cat <<EOF > /etc/vconsole.conf
KEYMAP=us
FONT=ter-v32b
EOF

# ------------------------------------------------------------------------

echo
echo "Disabling buggy cursor inheritance"

# When you boot with multiple monitors the cursor can look huge. This fixes it.
sudo cat <<EOF > /usr/share/icons/default/index.theme
[Icon Theme]
#Inherits=Theme
EOF

# ------------------------------------------------------------------------

echo
echo "Enable AMD Tear Free"

sudo cat <<EOF > /etc/X11/xorg.conf.d/20-amdgpu.conf
Section "Device"
     Identifier "AMD"
     Driver "amdgpu"
     Option "TearFree" "true"
EndSection
EOF

# ------------------------------------------------------------------------
echo
echo "Increasing file watcher count"

# This prevents a "too many files" error in Visual Studio Code
echo fs.inotify.max_user_watches=524288 | sudo tee /etc/sysctl.d/40-max-user-watches.conf && sudo sysctl --system

# ------------------------------------------------------------------------

echo
echo "Disabling Pulse .esd_auth module"

# Pulse audio loads the `esound-protocol` module, which best I can tell is rarely needed.
# That module creates a file called `.esd_auth` in the home directory which I'd prefer to not be there. So...
sudo sed -i 's|load-module module-esound-protocol-unix|#load-module module-esound-protocol-unix|g' /etc/pulse/default.pa

# ------------------------------------------------------------------------

echo
echo "Enabling Login Display Manager"

sudo systemctl enable lightdm.service
sudo systemctl start lightdm.service

# ------------------------------------------------------------------------

echo
echo "Enabling Cronie"

touch /etc/crontab

sudo systemctl start cronie
sudo systemctl start cronie.service
sudo systemctl enable cronie
sudo systemctl enable cronie.service

# ------------------------------------------------------------------------

echo
sudo ntpd -qg
sudo systemctl enable ntpd.service
sudo systemctl start ntpd.service
sudo systemctl disable dhcpcd.service
sudo systemctl stop dhcpcd.service
sudo systemctl disable ssh.service
sudo systemctl stop ssh.service
sudo systemctl enable NetworkManager.service
sudo systemctl start NetworkManager.service
echo "
###############################################################################
# Cleaning
###############################################################################
"
# Remove no password sudo rights
sed -i 's/^%wheel ALL=(ALL) NOPASSWD: ALL/# %wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
# Add sudo rights
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

# Clean orphans pkg
if [[ ! -n $(pacman -Qdt) ]]; then
	echo "No orphans to remove."
else
	pacman -Rns $(pacman -Qdtq)
fi

# Replace in the same state
cd ~/
echo "
###############################################################################
# Done
###############################################################################
"