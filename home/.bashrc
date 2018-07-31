#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi

alias ls='ls --color=auto -a'
PS1='[\u@\h \W]\$ '

source ~/.homesick/repos/homeshick/homeshick.sh

eval $(keychain --eval --quiet id_rsa id_dsa)

