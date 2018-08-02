#!/usr/bin/bash 

set -e

pacman -Syu
pacman -S git fzf rg zsh keychain
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
source ~/.homesick/repos/homeshick/homeshick.sh

