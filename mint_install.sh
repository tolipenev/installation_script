#!/bin/bash

set -e

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
PKGS_TO_INSTALL='curl wget git zsh micro xclip apt-transport-https npm p7zip nodejs chromium docker'
sudo apt update && sudo apt dist-upgrade -y
INSTALL_COMMAND="sudo apt install -y"


## Installation process
printmessage "$YELLOW" "Installing packages..."
$INSTALL_COMMAND $PKGS_TO_INSTALL
printmessage "$GREEN" "Package installation completed"


## VSCode setup
printmessage "$BLUE" "Setting up VSCode"
sudo curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

printmessage "$YELLOW" "Installing VSCode"
$INSTALL_COMMAND code

## Shell installation process
printmessage "$YELLOW" "Installing OhMyZSH..."
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

printmessage "$BLUE" "Changing shell..."
chsh -s $(which zsh)

printmessage "$YELLOW" "Installing shell customizations..."
sudo git clone --depth 1 git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
sudo git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sudo git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
sudo ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"


printmessage "$BLUE" "Copying profile with plugins..."
cat ./zshrc > $HOME/.zshrc

printmessage "$GREEN" "Copy done"

printmessage "$GREEN" "Shell installation completed"

## Script End
printmessage "$GREEN" "Installer has finished!"
