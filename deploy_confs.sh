#!/bin/bash
cd ~/
for x in '.vimrc' '.screenrc' '.toprc' '.bashrc' '.gitconfig';
do
    echo "Deploying $x..."
    ln -sf "repositories/configs/$x"
done
echo -e "\nHopefully, great success."
echo -e "\r"
ls -lah ~/
exit 0
