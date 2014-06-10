# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/login.defs
#umask 022

if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
    export PATH
fi

#android sdk setting
if [ -d $HOME/android-sdk-linux ] ; then
	export PATH=$PATH:$HOME/android-sdk-linux/platform-tools:$HOME/android-sdk-linux/tools
fi

export LANG=en_US.UTF-8
export ALTERNATE_EDITOR=emacs
export OOO_FORCE_DESKTOP=gnome
#http://awesome.naquadah.org/wiki/Problems_with_Java
export JAVA_AWT_WM_NONREPARENTING=1
