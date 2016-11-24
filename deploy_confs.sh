#!/bin/bash

cd ~/

for x in '.vimrc' '.screenrc' '.toprc' '.bashrc' '.gitconfig' '.tmux.conf';
do
    echo "Deploying $x..."
    ln -sf "repos/configs/$x"
done

if [ ! -d ".config" ]; then
    mkdir .config
    echo 'Created .config/ directory.'
fi

if [ ! -d ".config/i3" ]; then
    mkdir .config/i3
    echo 'Created .config/i3/ directory.'
fi

for x in 'config';
do
    echo "Deploying .config/i3/$x..."
    ln -sf "../../repos/configs/.config/i3/$x" ".config/i3/$x"
done

echo -e "\nHopefully, great success."
echo -e "\r"

ls -lah ~/

exit 0
