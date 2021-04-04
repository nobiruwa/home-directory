#!/bin/bash

# REPOS="dot-emacs.d.git gistish.git east-asian-ambiguous-width.git home-directory.git nobiruwa.github.io.git nobiruwa.github.io.master.git yasnippet-snippets.git"
REPOS="*.git"

ROOT_DIR=`pwd`

for repo in $REPOS; do
    echo enter $repo...
    cd $repo
    git status
    git pull
    git status
    cd $ROOT_DIR
    echo leave $repo...
    echo ""
done
