#!/usr/bin/env bash

CUR_DIR=`pwd`

cd $HOME && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
cd $HOME && wget "https://www.dropbox.com/download?dl=packages/dropbox.py" -O $HOME/bin/dropbox.py && chmod +x $HOME/bin/dropbox.py

cd $CUR_DIR
