#!/bin/bash
cd ~/
for x in '.vimrc' '.screenrc' '.toprc' '.bashrc' '.gitconfig' '.tmux.conf';
do
    echo "Deploying $x..."
    ln -sf "repos/configs/$x"
done
echo -e "\nHopefully, great success."
echo -e "\r"
ls -lah ~/
exit 0
