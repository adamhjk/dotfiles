#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto -a'
PS1='[\u@\h \W]\$ '

source ~/.homesick/repos/homeshick/homeshick.sh
