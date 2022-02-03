#! /bin/bash

sudo a2disconf localized-error-pages javascript-common

# rarely if ever need apache directory indexes these days, can turn back on if need be
#   status (/server-status) can turn on if need be
sudo a2dismod autoindex status
