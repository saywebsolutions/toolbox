#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific aliases and functions

#USER=`id -un`
LOGNAME=$USER
MAIL="/var/spool/mail/$USER"

HOSTNAME=`/bin/hostname`
HISTSIZE=1000000
HISTFILESIZE=10000000

alias w="w | sort"
alias who="who | sort"
alias last="last -a | less"
alias grpe="grep --color"
alias grep="grep --color"
alias vi="vim"

PAGER=less
VISUAL=vi
FCEDIT=vi

PS1='^[[1;31m\u^[[0;37m@^[[0;36m\h^[[0;32m\w^[[0;37m\n> '

PATH="/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/lib:/usr/X11R6/bin:/usr/X11R6/lib:/usr/java/bin:/usr/java/lib"
MANPATH="/usr/local/man:/usr/man:/usr/local/share/man:/usr/share/man:/usr/share/binutils-data/i686-pc-linux-gnu/2.17/man:/usr/share/gcc-data/i686-pc-linux-gnu/3.4.4/man:/usr/qt/3/doc/man"
