# Downloading Scripts

curl -o filename https://raw.githubusercontent.com/Quickshadow10/ArchInstaller/refs/heads/main/1-base.sh
curl -o filename https://raw.githubusercontent.com/Quickshadow10/ArchInstaller/refs/heads/main/2-software-pacman.sh
curl -o filename https://raw.githubusercontent.com/Quickshadow10/ArchInstaller/refs/heads/main/3-software-aur.sh
curl -o filename https://raw.githubusercontent.com/Quickshadow10/ArchInstaller/refs/heads/main/4-post-setup.sh
curl -o filename https://raw.githubusercontent.com/Quickshadow10/ArchInstaller/refs/heads/main/5-awesome-config.sh

sh 1-base.sh
sh 2-software-pacman.sh
sh software-aur.sh
sh post-setup.sh
sh awesome-config.sh


echo
echo "You are installed, you may proceed."
echo