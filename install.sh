#!/usr/bin/bash 

set -e

sudo pacman -Syu
sudo pacman -Sy git fzf ripgrep zsh keychain vim
if [[ ! -d "$HOME/.zplug" ]]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi
if [[ ! -d "$HOME/.homesick" ]]; then
  git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
fi
source ~/.homesick/repos/homeshick/homeshick.sh

if [[ ! -d "$HOME/.homesick/repos/dotfiles" ]]; then
  homeshick -b clone http://github.com/adamhjk/dotfiles
fi
