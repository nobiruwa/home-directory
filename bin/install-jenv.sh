#!/usr/bin/env bash

git clone https://github.com/gcuisinier/jenv.git ~/.jenv

JENV_HOME="$HOME/.jenv"
JENV_BIN="$JENV_HOME/bin"

PATH="$JENV_BIN:$PATH"
eval "$(jenv init --path)"
eval "$(jenv init -)"
