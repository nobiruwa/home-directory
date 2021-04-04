#!/bin/bash

REPOS="*.git"

ROOT_DIR=`pwd`

for repo in $REPOS; do
    echo enter $repo...
    cd $repo
    git config pull.rebase false
    cd $ROOT_DIR
    echo leave $repo...
    echo ""
done
