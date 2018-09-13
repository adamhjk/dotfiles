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
export PATH=$PATH:~/.cargo/bin:~/bin

# Aliases
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias ls='ls -aG'
else
  alias ls='ls --color=auto -a'
fi
alias nvim='vim'
if [[ -f "/usr/bin/bat" ]]; then
  alias cat='bat'
fi

# Homeshick
source ~/.homesick/repos/homeshick/homeshick.sh

if [[ -f "$HOME/.ssh/id_rsa" ]]; then
  # Keychain
  eval $(keychain --eval --quiet id_rsa id_dsa)
fi

# Theme
export PROMPT_GEOMETRY_COLORIZE_SYMBOL=true

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
if [[ -f "/usr/share/fzf/completion.zsh" ]]; then
  source /usr/share/fzf/completion.zsh
fi
if [[ -f "/usr/local/opt/fzf/shell/completion.zsh" ]]; then
  source /usr/local/opt/fzf/shell/completion.zsh
fi

# If we are in SSH, and running termite, then set the term correctly
if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
  if [[ "$TERM" = "xterm-termite" ]]; then
    export TERM=xterm-256color
  fi
fi

# Iterm 2
test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

# Travis CI
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

# Hab Auth Token
[ -f $HOME/.HAB_AUTH_TOKEN ] && source $HOME/.HAB_AUTH_TOKEN
