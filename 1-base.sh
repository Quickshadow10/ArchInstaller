echo
echo "Installing Base System"
echo

# Add sudo no password rights
sed -i 's/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers

PKGS=(

    # --- XORG Display Rendering
        'xorg'                  # Base Package
        'xorg-drivers'          # Display Drivers 
        'xterm'                 # Terminal for TTY
        'xorg-server'           # XOrg server
        'xorg-apps'             # XOrg apps group
        'xorg-xinit'            # XOrg init
        'xorg-xinput'           # XOrg xinput
        'mesa'                  # Open source version of OpenGL
        'xf86-video-amdgpu'     # XOrg amdgpu video driver

    # --- Setup Desktop
        'awesome'               # Awesome Desktop
        'xfce4-power-manager'   # Power Manager 
        'rofi'                  # Menu System
        'picom'                 # Translucent Windows
        'xclip'                 # System Clipboard
        'gnome-polkit'          # Elevate Applications
        'lxappearance'          # Set System Themes

    # --- Login Display Manager
        'lightdm'                   # Base Login Manager
        'lightdm-webkit2-greeter'   # Framework for Awesome Login Themes

    # --- Networking Setup
        'dialog'                    # Enables shell scripts to trigger dialog boxex
        'networkmanager'            # Network connection manager
        'openvpn'                   # Open VPN support
        'networkmanager-openvpn'    # Open VPN plugin for NM
        'network-manager-applet'    # System tray icon/utility for network connectivity
        'dhclient'                  # DHCP client
        'libsecret'                 # Library for storing passwords
        'fail2ban'                  # Ban IP's after man failed login attempts
        'ufw'                       # Uncomplicated firewall
    
    # --- Audio
        'alsa-utils'        # Advanced Linux Sound Architecture (ALSA) Components https://alsa.opensrc.org/
        'alsa-plugins'      # ALSA plugins
        'pulseaudio'        # Pulse Audio sound components
        'pulseaudio-alsa'   # ALSA configuration for pulse audio
        'pavucontrol'       # Pulse Audio volume control
        'pnmixer'           # System tray volume control

    # --- Bluetooth
        'bluez'                 # Daemons for the bluetooth protocol stack
        'bluez-utils'           # Bluetooth development and debugging utilities
        'bluez-libs'            # Bluetooth libraries
        'bluez-firmware'        # Firmware for Broadcom BCM203x and STLC2300 Bluetooth chips
        'blueberry'             # Bluetooth configuration tool
        'pulseaudio-bluetooth'  # Bluetooth support for PulseAudio
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

echo
echo "Done!"
echo
