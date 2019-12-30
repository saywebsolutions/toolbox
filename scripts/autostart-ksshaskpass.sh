#!/bin/sh

#install to ~/.config/autostart-scripts/

SSH_ASKPASS='/usr/bin/ksshaskpass'
export SSH_ASKPASS

ssh-add < /dev/null
