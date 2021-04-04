#!/bin/bash

URL_TEMPLATE="https://github.com/nobiruwa/"
REPOS="dot-emacs.d.git east-asian-ambiguous-width.git gistish.git home-directory.git nobiruwa.github.io.git win-dot-emacs.d.git wsl-dot-emacs.d.git wsl-home-directory.git yasnippet-snippets.git"

ROOT_DIR=`pwd`

for repo in $REPOS; do
    echo clone $repo...
    git clone $URL_TEMPLATE$repo $repo
    echo ""
done

echo clone nobiruwa.github.io.master.git...
git clone $URL_TEMPLATE --branch master nobiruwa.github.io.git nobiruwa.github.io.master.git
echo ""
