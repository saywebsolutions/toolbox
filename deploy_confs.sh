#!/bin/bash

# check for existence of curl
if [ ! -x /usr/bin/curl ] ; then
    # command is posix compliant way to check for a program, in case curl isn't in /usr/bin
    command -v curl >/dev/null 2>&1 || { echo >&2 "Please install curl. Aborting."; exit 1; }
fi

cd ~/

for x in '.vimrc' '.screenrc' '.toprc' '.bashrc' '.bash_profile' '.gitconfig' '.tmux.conf' '.sqliterc';
do
    echo "Deploying $x..."
    ln -sf "repos/toolbox/$x"
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
    ln -sf "../../repos/toolbox/.config/i3/$x" ".config/i3/$x"
done

if [ ! -d ".config/nvim" ]; then
    mkdir .config/nvim
    echo 'Created .config/nvim/ directory.'
fi

for x in 'init.vim';
do
    echo "Deploying .config/nvim/$x..."
    ln -sf "../../repos/toolbox/.vimrc" ".config/nvim/$x"
done

# VIM PACKAGE MANAGEMENT USING PATHOGEN + PLUGINS

#if [ ! -e ".vim/autoload/pathogen.vim" ]; then

#  echo -e "\nInstalling Pathogen for managing vim plugins."
#  echo -e "\r"

#  mkdir -p .vim/autoload .vim/bundle && curl -LSso .vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

#fi

cd ~/

#if [ ! -d ".vim/bundle/vim-gitgutter" ]; then
#  cd .vim/bundle && git clone git://github.com/airblade/vim-gitgutter.git && cd ~/
#fi

if [ ! -d ".vim/bundle/vim-fugitive" ]; then
  cd .vim/bundle && git clone git@github.com:tpope/vim-fugitive.git && cd ~/
fi

if [ ! -d ".vim/bundle/vim-surround" ]; then
  cd .vim/bundle && git clone git://github.com/tpope/vim-surround.git && cd ~/
fi

if [ ! -d ".vim/bundle/vim-eunuch" ]; then
  cd .vim/bundle && git clone git://github.com/tpope/vim-eunuch.git && cd ~/
fi

if [ ! -d ".vim/bundle/ctrlp.vim" ]; then
  cd .vim/bundle && git clone git://github.com/ctrlpvim/ctrlp.vim && cd ~/
fi

#if [ ! -d ".vim/bundle/ultisnips" ]; then
#  cd .vim/bundle && git clone git://github.com/SirVer/ultisnips.git && cd ~/
#fi

#if [ ! -d ".vim/bundle/vim-snippets" ]; then
#  cd .vim/bundle && git clone git://github.com/honza/vim-snippets.git && cd ~/
#fi

#if [ ! -d ".vim/bundle/vim-airline" ]; then
#  cd .vim/bundle && git clone git://github.com/bling/vim-airline && cd ~/
#fi

#if [ ! -d ".vim/bundle/vim-airline-themes" ]; then
#  cd .vim/bundle && git clone git://github.com/vim-airline/vim-airline-themes && cd ~/
#fi

#if [ ! -d ".vim/bundle/vim-css-color" ]; then
#  cd .vim/bundle && git clone git://github.com/ap/vim-css-color && cd ~/
#fi

#if [ ! -d ".vim/bundle/vim-php-cs-fixer" ]; then
#  cd .vim/bundle && git clone git://github.com/stephpy/vim-php-cs-fixer.git && cd ~/
#fi

#if [ ! -d ".vim/bundle/vim-blade" ]; then
#  cd .vim/bundle && git clone git://github.com/jwalton512/vim-blade.git && cd ~/
#fi

#if [ ! -d ".vim/bundle/PHP-Indenting-for-VIm" ]; then
#  cd .vim/bundle && git clone git://github.com/2072/PHP-Indenting-for-VIm.git && cd ~/
#fi

#if [ ! -d ".vim/bundle/vim-rooter" ]; then
#  cd .vim/bundle && git clone git://github.com/airblade/vim-rooter.git && cd ~/
#fi

#if [ ! -d ".vim/bundle/fzf" ]; then
#  cd .vim/bundle && git clone git://github.com/junegunn/fzf.git && cd ~/
#fi

#if [ ! -d ".vim/bundle/fzf.vim" ]; then
#  cd .vim/bundle && git clone git://github.com/junegunn/fzf.vim.git && cd ~/
#fi

#if [ ! -d ".vim/bundle/neomake" ]; then
#  cd .vim/bundle && git clone git://github.com/neomake/neomake.git && cd ~/
#fi

#if [ ! -d ".vim/bundle/vim-gutentags" ]; then
#  cd .vim/bundle && git clone git@github.com:ludovicchabant/vim-gutentags.git && cd ~/
#fi

if [ ! -d ".vim/bundle/phpcomplete.vim" ]; then
  cd .vim/bundle && git clone git@github.com:shawncplus/phpcomplete.vim.git && cd ~/
fi

#if [ ! -d ".vim/bundle/lightline.vim" ]; then
#  cd .vim/bundle && git clone git@github.com:itchyny/lightline.vim.git && cd ~/
#fi

#if [ ! -d ".vim/bundle/tagbar" ]; then
#  cd .vim/bundle && git clone git@github.com:majutsushi/tagbar.git && cd ~/
#fi

#if [ ! -d ".vim/bundle/lightline-ale" ]; then
#  cd .vim/bundle && git clone git@github.com:maximbaz/lightline-ale.git && cd ~/
#fi

if [ ! -d ".vim/bundle/supertab" ]; then
  cd .vim/bundle && git clone git@github.com:ervandew/supertab.git && cd ~/
fi

if [ ! -d ".vim/bundle/ale" ]; then
  cd .vim/bundle && git clone https://github.com/dense-analysis/ale.git && cd ~/
fi

# vim swap and backup files dir
if [ ! -d ".vim/swapfiles" ]; then
  mkdir -p ~/.vim/swapfiles && cd ~/
fi

#themes

# vim swap and backup files dir
if [ ! -d ".vim/colors" ]; then
  mkdir -p ~/.vim/colors && cd ~/
fi

if [ ! -d ".vim/bundle/vim-colors-solarized" ]; then
  cd .vim/bundle && git clone git://github.com/altercation/vim-colors-solarized.git && cd ~/
  cp ~/.vim/bundle/vim-colors-solarized/colors/solarized.vim ~/.vim/colors/ && cd ~/
fi

#dependencies
#handled by plug vim plugin manager
#if [ ! -d ".fzf" ]; then
#  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
#  ~/.fzf/install
#fi

echo -e "\nLinking custom snippets."
ln -sf "../repos/toolbox/my-snippets/" ".vim/"

echo -e "\nHopefully, great success."
echo -e "\r"

ls -lah ~/

exit 0
