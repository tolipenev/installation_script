#!/bin/bash

set -ex

RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
MAGENTA="\e[35m"
YELLOW="\e[33m"
ENDCOLOR="\e[0m"

printmessage() {
    printf "${1}${2}${ENDCOLOR}\n" ## ask about this
}

## Welcome banner
echo -e "${MAGENTA}
 ██▓ ███▄    █   ██████ ▄▄▄█████▓ ▄▄▄       ██▓     ██▓    ▓█████  ██▀███
▓██▒ ██ ▀█   █ ▒██    ▒ ▓  ██▒ ▓▒▒████▄    ▓██▒    ▓██▒    ▓█   ▀ ▓██ ▒ ██▒
▒██▒▓██  ▀█ ██▒░ ▓██▄   ▒ ▓██░ ▒░▒██  ▀█▄  ▒██░    ▒██░    ▒███   ▓██ ░▄█ ▒
░██░▓██▒  ▐▌██▒  ▒   ██▒░ ▓██▓ ░ ░██▄▄▄▄██ ▒██░    ▒██░    ▒▓█  ▄ ▒██▀▀█▄
░██░▒██░   ▓██░▒██████▒▒  ▒██▒ ░  ▓█   ▓██▒░██████▒░██████▒░▒████▒░██▓ ▒██▒
░▓  ░ ▒░   ▒ ▒ ▒ ▒▓▒ ▒ ░  ▒ ░░    ▒▒   ▓▒█░░ ▒░▓  ░░ ▒░▓  ░░░ ▒░ ░░ ▒▓ ░▒▓░
 ▒ ░░ ░░   ░ ▒░░ ░▒  ░ ░    ░      ▒   ▒▒ ░░ ░ ▒  ░░ ░ ▒  ░ ░ ░  ░  ░▒ ░ ▒░
 ▒ ░   ░   ░ ░ ░  ░  ░    ░        ░   ▒     ░ ░     ░ ░      ░     ░░   ░
 ░           ░       ░                 ░  ░    ░  ░    ░  ░   ░  ░   ░

${ENDCOLOR}
"

INSTALL_COMMAND=""

## Detect the platform ## minor questions here(more OS?) (reference here https://stackoverflow.com/questions/394230/how-to-detect-the-os-from-a-bash-script and here https://danielgibbs.co.uk/2013/04/bash-how-to-detect-os/)

getOsAndInstaller(){
case "$OSTYPE" in
solaris*) echo -e "You are running:" "$BLUE SOLARIS $ENDCOLOR" && INSTALL_COMMAND="banana" ;;
ubuntu*) echo -e "You are running:" "$BLUE UBUNTU $ENDCOLOR"  && INSTALL_COMMAND="sudo apt install -y" ;;
debian*) echo -e "You are running:" "$BLUE DEBIAN $ENDCOLOR" ;;
arch*) echo -e "You are running:" "$BLUE ARCH $ENDCOLOR" && INSTALL_COMMAND="sudo pacman -Suuy --no-confirm" ;;
manjaro*) echo -e "You are running:" "$BLUE MANJARO $ENDCOLOR" && INSTALL_COMMAND="sudo pacman -Suuy --no-confirm"  ;;
bsd*) echo -e "You are running:" "$BLUE BSD $ENDCOLOR" ;;
msys*) echo -e "You are running:" "$BLUE WINDOWS $ENDCOLOR" && INSTALL_COMMAND="choco install -y" ;;
*) echo -e "$RED Unknown: $OSTYPE $ENDCOLOR" ;;
esac
}

getOsAndInstaller


## Info about installation
echo -e "This script will install the following programs:""$BLUE programs and tools and whatever $ENDCOLOR"

# echo "Do you wish to continue?"  (here https://stackoverflow.com/questions/226703/how-do-i-prompt-for-yes-no-cancel-input-in-a-linux-shell-script)
# select YyNn in "Yes" "No"; do
#     case $YyNn in
#     Yes)
#         make install
#         break
#         ;;
#     No) exit ;;
#     esac
# done

# PKGS_TO_INSTALL="names of packages to be installed zsh"
# INSTALL_COMMAND="" (reference https://distrowatch.com/dwres.php?resource=package-management)
# if else for choosing appropriate package manager based on what OS the scripts runs on

## Installation process
printmessage "$YELLOW" "Installing packages..."
# $INSTALL_COMMAND $PKGS_TO_INSTALL
printmessage "$GREEN" "Package installation completed"

## YAY installation
printmessage "$YELLOW" "Installing YAY..."
printmessage "$GREEN" "Installation complete"

# Shell installation process
printmessage "$YELLOW" "Installing shell..."

# echo "Choose what shell do you want to use:" (reference https://www.tecmint.com/different-types-of-linux-shells/ )
# select bash in "B" tcsh in "C" ksh in "K" zsh in "Z" fish in "F"; do
#     case $BbCcKkZzFf in
#     Yes)
#         install the chosen shell
#         break
#         ;;
#     No) exit ;;
#     esac
# done
printmessage "$YELLOW" "Do you want to switch to the new shell ?"

printmessage "$GREEN" "Shell installation completed"

## Script End
printmessage "$GREEN" "Installer has finished!"
