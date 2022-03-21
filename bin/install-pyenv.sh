#!/usr/bin/env bash

git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv

# 一時的に`$HOME/.pyenv/bin`を`$PATH`に追加してpyenv-virtualenvをインストールする
PYENV_HOME="$HOME/.pyenv"
PYENV_BIN="$PYENV_HOME/bin"

PATH="$PYENV_BIN:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

mkdir -p $(pyenv root)/plugins
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
