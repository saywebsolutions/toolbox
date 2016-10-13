#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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

# Mac OSX
if [[ "$OSTYPE" == "darwin"* ]]; then

	export CLICOLOR=1
	export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
	alias ll='ls -lah'

else

	alias w="w | sort"
	alias who="who | sort"
	alias last="last -a | less"
	alias ls='ls --color=auto'
	alias ll='ls -lah --color=auto'
	alias grpe="grep --color"
	alias grep="grep --color"
	alias vi="vim"

fi

PAGER=less
VISUAL=vim
FCEDIT=vim
EDITOR=vim

PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] '
# root
#PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[0;31m\]\$ '

PATH="/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/lib:/usr/X11R6/bin:/usr/X11R6/lib:/usr/java/bin:/usr/java/lib:~/.composer/vendor/bin"
MANPATH="/usr/local/man:/usr/man:/usr/local/share/man:/usr/share/man:/usr/share/binutils-data/i686-pc-linux-gnu/2.17/man:/usr/share/gcc-data/i686-pc-linux-gnu/3.4.4/man:/usr/qt/3/doc/man"
