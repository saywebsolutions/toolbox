#!/usr/bin/env sh

# Install system dependencies
sudo apt install libncurses5-dev python-dev python3-dev git checkinstall

# Remove Vim if you already have 
sudo apt remove vim vim-runtime gvim  

# Configure and make
cd ~/repos
git clone https://github.com/vim/vim.git
cd vim

sudo make distclean

sudo ./configure \
    --with-features=huge \
    --without-x \
    --disable-xsmp \
    --disable-rightleft --disable-arabic \
    --enable-python3interp \
    --with-python3-command=python3 \
    --with-python3-config-dir=$(python3-config --configdir|rev|cut -d/ -f1 --complement|rev) \
    --enable-rubyinterp
    --disable-gui \
    --enable-cscope \
    --disable-netbeans \
    --enable-fail-if-missing \
    --prefix=/usr/local/
    
#sudo make VIMRUNTIMEDIR=/usr/local/share/vim/vim81 

sudo make

# Install
#sudo checkinstall
sudo make install

# Set Vim as a default editor
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 100
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 100
sudo update-alternatives --set vi /usr/local/bin/vim
sudo update-alternatives --install /etc/alternatives/vim vim /usr/local/bin/vim 100
#sudo update-alternatives --set vim /usr/local/bin/vim

# Check if it worked
vim --version
