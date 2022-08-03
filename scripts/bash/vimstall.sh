#!/usr/bin/env sh

# Install system dependencies
sudo apt install libncurses5-dev python-dev python3-dev git checkinstall

# Remove Vim if you already have 
sudo apt remove vim vim-runtime gvim  

# Configure and make
cd ~/repos
git clone https://github.com/vim/vim.git
cd vim  

./configure
    --with-features=huge \
    --enable-multibyte \
    --enable-python3interp=yes \
    --with-python3-config-dir=$(python3-config --configdir) \
    --enable-gui=no \
    --enable-cscope \ 
    --disable-netbeans \
    --enable-fail-if-missing \
    --prefix=/usr/local/

#sudo make VIMRUNTIMEDIR=/usr/local/share/vim/vim81 

make

# Install
sudo checkinstall

# Set Vim as a default editor
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim   

# Check if it worked
vim --version
