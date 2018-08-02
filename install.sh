#!/usr/bin/bash 

set -e

pacman -Syu
pacman -S git fzf ripgrep zsh keychain vim
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
source ~/.homesick/repos/homeshick/homeshick.sh

