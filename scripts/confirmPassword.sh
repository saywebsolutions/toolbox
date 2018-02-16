#!/bin/sh

stty -echo
printf "Password: "
read PASSWORD
stty echo
printf "\n"
echo $PASSWORD

exit 0
