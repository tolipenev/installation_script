# Path to your oh-my-zsh installation.
export ZSH=/home/$USER/.oh-my-zsh

ZSH_THEME="spaceship"


plugins=(git colorize npm zsh-autosuggestions zsh-navigation-tools zsh-syntax-highlighting command-not-found cp docker)

source $ZSH/oh-my-zsh.sh
ENABLE_CORRECTION="true"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
