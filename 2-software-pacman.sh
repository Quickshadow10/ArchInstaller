#!/usr/bin/env bash

echo "Installing Base System"
echo

PKGS=(
	# Teminal Utilities--------------------------------
	
	'bleachbit'
	'bleachbit'               # File deletion utility
    'cmatrix'                 # The Matrix screen animation
    'cronie'                  # cron jobs
    'curl'                    # Remote content retrieval
    'file-roller'             # Archive utility
    'gtop'                    # System monitoring via terminal
    'gufw'                    # Firewall manager
    'hardinfo'                # Hardware info app
    'htop'                    # Process viewer
    'neofetch'                # Shows system info when you launch terminal
    'ntp'                     # Network Time Protocol to set time via network.
    'numlockx'                # Turns on numlock in X11
    'p7zip'                   # 7z compression program
    'rsync'                   # Remote file sync utility
    'speedtest-cli'           # Internet speed via terminal
    'terminus-font'           # Font package with some bigger fonts for login terminal
    'unrar'                   # RAR compression program
    'unzip'                   # Zip compression program
    'wget'                    # Remote content retrieval
    'terminator'              # Terminal emulator
    'nano'                    # Terminal Editor
    'zenity'                  # Display graphical dialog boxes via shell scripts
    'zip'                     # Zip compression program
    'zsh'                     # Interactive shell
    'zsh-autosuggestions'     # Zsh Plugin
    'zsh-syntax-highlighting' # Zsh Plugin
	
	# GENERAL UTILITIES ---------------------------------------------------

	'variety'               # Wallpaper changer
	'clamav'                # Anti-virus

	# DEVELOPMENT ---------------------------------------------------------

	'gedit'                 # Text editor
	'clang'                 # C Lang compiler
	'cmake'                 # Cross-platform open-source make system
	'code'                  # Visual Studio Code
	'electron'              # Cross-platform development using Javascript
	'git'                   # Version control system
	'gcc'                   # C/C++ compiler
	'glibc'                 # C libraries
	'meld'                  # File/directory comparison
	'nodejs'                # Javascript runtime environment
	'npm'                   # Node package manager
	'python'                # Scripting language

    # MEDIA ---------------------------------------------------------------

    'vlc'                   # Video player
    'feh'                   # Image viewer

    # PRODUCTIVITY --------------------------------------------------------

    'hunspell'              # Spellcheck libraries
    'hunspell-en'           # English spellcheck library
    'xpdf'                  # PDF viewer

)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

echo
echo "Done!"
echo
