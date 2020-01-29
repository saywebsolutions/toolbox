#!/bin/bash

cd ~/

if [ ! -d "repos" ]; then
    mkdir repos && cd repos
    echo 'Created repos directory.'
else
    cd repos
fi

if [ ! -d "toolbox-releases" ]; then
    mkdir toolbox-releases && cd toolbox-releases
    echo 'Created /repos/toolbox-releases directory.'
else
    cd toolbox-releases
fi

wget https://github.com/saywebsolutions/toolbox/archive/master.zip

DIRNAME=toolbox-$(date +%Y%m%d%H%M%S)

unzip master.zip -d $DIRNAME

rm master.zip

cd $DIRNAME/toolbox-master

cp -rT . ../

cd ../

rm -rf toolbox-master

cd ../../

if [ ! -d "toolbox/.git" ]; then
  ln -snf toolbox-releases/$DIRNAME toolbox
else
  echo 'VCS detected, aborting update.'
fi

~/repos/toolbox/./deploy_confs.sh
