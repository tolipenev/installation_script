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
PKGS_TO_INSTALL='git base-devel ulauncher binutils zsh micro xclip npm p7zip nodejs docker docker-machine docker-compose yay'
sudo pacman -Syy --noconfirm
INSTALL_COMMAND="sudo pacman -S --noconfirm"
YAY_COMMAND="yay -S --noconfirm"

## Installation process
printmessage "$YELLOW" "Installing packages..."
$INSTALL_COMMAND $PKGS_TO_INSTALL
printmessage "$GREEN" "Package installation completed"

## Docker Setup
printmessage "$BLUE" "Setting up docker"
sudo systemctl enable docker.socket
sudo systemctl enable docker.service
sudo systemctl start docker.socket
sudo systemctl start docker.service
sudo usermod -aG docker $USER
printmessage "$GREEN" "Docker setup done"

## Chrome Setup
printmessage "$YELLOW" "Installing Chrome"
$YAY_COMMAND google-chrome

## VSCode Setup
printmessage "$YELLOW" "Installing VSCode"
$YAY_COMMAND visual-studio-code-bin

## Shell installation process
printmessage "$BLUE" "Changing shell to Zsh"
chsh -s /bin/zsh

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
