# Adam's ZSHRC

autoload -Uz compinit promptinit
compinit
promptinit

# VI Mode
bindkey -v
export EDITOR=vim
export VISUAL=vim
export KEYTIMEOUT=1

# Completion
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt COMPLETE_ALIASES
setopt SHARE_HISTORY
setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_ALL_DUPS

# Path
typeset -U path
export PATH=$PATH:~/.cargo/bin

# Aliases
alias ls='ls --color=auto -a'

# Homeshick
source ~/.homesick/repos/homeshick/homeshick.sh

# Keychain
eval $(keychain --eval --quiet id_rsa id_dsa)

# Zplug
source ~/.zplug/init.zsh

zplug "zuxfoucault/colored-man-pages_mod"
zplug "zdharma/fast-syntax-highlighting"
zplug "ytet5uy4/fzf-widgets"
zplug "softmoth/zsh-vim-mode"
zplug "geometry-zsh/geometry"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load 

# fzf widgets
bindkey '^r'  fzf-insert-history
source /usr/share/fzf/completion.zsh
