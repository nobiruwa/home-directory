# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# android sdk setting
ANDROID_HOME=$HOME/opt/android-sdk-linux
if [ -d $ANDROID_HOME ] ; then
    export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$PATH"
fi

# Node.js setting
# npm global package go to ~/.node,
# not forget 'echo prefix=~/.node >> $HOME/.npmrc'
# (caution: $HOME does not work in .npmrc)
NPMBIN=$HOME/.node/bin
if [ -d $NPMBIN ] ; then
    export PATH="$NPMBIN:$PATH"
fi

# Cabal (Haskell packages)
CABALBIN=$HOME/.cabal/bin
if [ -d $CABALBIN ] ; then
    PATH="$CABALBIN:$PATH"
fi

# XDG base directory setting
LOCALBIN=$HOME/.local/bin
if [ -d $LOCALBIN ] ; then
    PATH="$LOCALBIN:$PATH"
fi

export LANG=en_US.UTF-8
export ALTERNATE_EDITOR=emacs
export OOO_FORCE_DESKTOP=gnome
#http://awesome.naquadah.org/wiki/Problems_with_Java
export JAVA_AWT_WM_NONREPARENTING=1

# # set PATH so it includes user's private bin if it exists
# if [ -d "$HOME/bin" ] ; then
#     PATH="$HOME/bin:$PATH"
# fi


# if [ -d "$HOME/android-sdk-linux" ] ; then
#     PATH="$HOME/android-sdk-linux/tools:$HOME/android-sdk-linux/platform-tools:$PATH"
# fi

# npm global package go to ~/.node,
# not forget 'echo prefix=~/.node >> $HOME/.npmrc'
# (caution: $HOME does not work in .npmrc)
# if [ -d "$HOME/.node" ] ; then
#     PATH="$HOME/.node/bin:$PATH"
# fi

# if [ -d "$HOME/.local/bin" ] ; then
#     PATH="$HOME/.local/bin:$PATH"
# fi

# if [ -d "$HOME/.cabal/bin" ] ; then
#     PATH="$HOME/.cabal/bin:$PATH"
# fi
