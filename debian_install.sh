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
PKGS_TO_INSTALL='curl wget git zsh micro xclip apt-transport-https npm p7zip nodejs docker'
sudo apt update && sudo apt dist-upgrade -y
INSTALL_COMMAND="sudo apt install -y"

## Installation process
printmessage "$YELLOW" "Installing packages..."
$INSTALL_COMMAND $PKGS_TO_INSTALL
printmessage "$GREEN" "Package installation completed"

## Chrome Setup
printmessage "$BLUE" "Setting up Chrome"
sudo wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
sudo apt update -y

printmessage "$YELLOW" "Installing Chrome"
$INSTALL_COMMAND google-chrome-stable
## VSCode Setup
printmessage "$BLUE" "Setting up VSCode"
sudo curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >$HOME/microsoft.gpg
sudo install -o root -g root -m 644 $HOME/microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update -y

printmessage "$YELLOW" "Installing VSCode"
$INSTALL_COMMAND code

## Shell installation process
printmessage "$BLUE" "Changing shell to Zsh"
chsh -s /usr/bin/zsh

printmessage "$YELLOW" "Installing OhMyZSH..."
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" </dev/null

printmessage "$YELLOW" "Installing shell customizations..."

git clone --depth 1 git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sudo git clone --depth 1 https://github.com/denysdovhan/spaceship-prompt.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt
sudo ln -s ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt/spaceship.zsh-theme ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship.zsh-theme

printmessage "$BLUE" "Copying profile with plugins..."
cp -i .zshrc $HOME/.zshrc
cp -i .zshrcextra $HOME/.zshrcextra

printmessage "$GREEN" "Shell installation completed"

## Script End
printmessage "$GREEN" "Installer has finished! Reload terminal to finish up!"
