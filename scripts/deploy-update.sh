#!/bin/bash

cd ~/

if [ ! -d "repos" ]; then
    mkdir repos && cd repos
    echo 'Created repos directory.'
else
    cd repos
fi

if [ ! -d "configs-releases" ]; then
    mkdir configs-releases && cd configs-releases
    echo 'Created /repos/configs-releases directory.'
else
    cd configs-releases
fi

wget https://github.com/whabash090/configs/archive/master.zip

DIRNAME=configs-$(date +%Y%m%d%H%M%S)

unzip master.zip -d $DIRNAME

rm master.zip

cd $DIRNAME/configs-master

cp -rT . ../

cd ../

rm -rf configs-master

cd ../../

if [ ! -d "configs/.git" ]; then
  ln -snf $DIRNAME configs
else
  echo 'VCS detected, aborting update.'
fi
