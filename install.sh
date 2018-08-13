#!/usr/bin/bash 

set -e

if [[ -f "/etc/arch-release" ]]; then
  echo true | sudo sudo pacman --noconfirm -Syu git fzf ripgrep zsh keychain vim
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  if [[ ! -f /usr/local/bin/brew ]]; then 
	  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  brew install git fzf keychain ripgrep vim
fi

if [[ ! -d "$HOME/.zplug" ]]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi
if [[ ! -d "$HOME/.homesick" ]]; then
  git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
fi
source ~/.homesick/repos/homeshick/homeshick.sh

if [[ ! -d "$HOME/.homesick/repos/dotfiles" ]]; then
  homeshick -b clone http://github.com/adamhjk/dotfiles
  homeshick -f link dotfiles
fi
