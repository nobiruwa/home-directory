#!/usr/bin/env bash

git clone https://github.com/nodenv/nodenv.git $HOME/.nodenv

# 一時的に`$HOME/.nodenv/bin`を`$PATH`に追加してnode-buildをインストールする
NODENV_HOME="$HOME/.nodenv"
NODENV_BIN="$NODENV_HOME/bin"

PATH="$NODENV_BIN:$PATH"
eval "$(nodenv init -)"

git clone https://github.com/nodenv/node-build.git "$(nodenv root)"/plugins/node-build
