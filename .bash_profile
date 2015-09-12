# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/login.defs
#umask 022

if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
    export PATH
fi

# Cabal (Haskell packages)
CABALBIN=$HOME/.cabal/bin
if [ -d $CABALBIN ] ; then
    PATH=$PATH:$CABALBIN
fi

# XDG base directory setting
LOCALBIN=$HOME/.local/bin
if [ -d $LOCALBIN ] ; then
    export PATH=$PATH:$LOCALBIN
fi

# Node.js setting
NPMBIN=$HOME/.node/bin
if [ -d $NPMBIN ] ; then
    export PATH=$PATH:$NPMBIN
fi

# android sdk setting
ANDROID_HOME=$HOME/opt/android-sdk-linux
if [ -d $ANDROID_HOME ] ; then
	export PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools
fi

export LANG=en_US.UTF-8
export ALTERNATE_EDITOR=emacs
export OOO_FORCE_DESKTOP=gnome
#http://awesome.naquadah.org/wiki/Problems_with_Java
export JAVA_AWT_WM_NONREPARENTING=1
