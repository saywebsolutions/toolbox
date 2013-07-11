#!/bin/bash

cd ~/
for x in '.vimrc' '.screenrc';
do
    echo "Deploying $x..."
    ln -sf $x .
done
echo -e "\nHopefully, great success."
echo -e "\r"
ls -lah
exit 0
