#!/bin/sh

USE_SESSION=awesome
export LANG=en_US.UTF-8
export CLUTTER_IM_MODULE=uim
export GTK_IM_MODULE=uim
export QT_IM_MODULE=uim
export QT4_IM_MODULE=uim

xset -b

if test -e $HOME/.Xresources; then
    xrdb -merge $HOME/.Xresources
else
    echo "Ignore $HOME/.Xresources..."
fi

sleep 5 && xset r rate 250 30 &
# Make Caps Lock a Control key
setxkbmap -layout us -option ctrl:nocaps

if test -e $HOME/.xkb/modifier.xkb ; then
    xkbcomp $HOME/.xkb/modifier.xkb $DISPLAY 2>&1 > /dev/null
else
    echo "Ignore $HOME/.xkb/modifier.xkb..."
fi

# device speicific configuration
if test -e $HOME/.xsession-local ; then
    . $HOME/.xsession-local
else
    echo "Ignore $HOME/.xsession-local..."
fi

# $HOME/.dropbox-dist/dropboxd &

# redshift-gtk
if test -x "`command -v redshift-gtk`" ; then
    redshift-gtk &
fi

# Emacs
# emacs-urxvt &
if test -x "`command -v emacs`" ; then
    emacs &
fi

# execute awesome
if test $USE_SESSION = awesome; then
    exec awesome
fi
# execute gnome-session
if test $USE_SESSION = gnome-session; then
    exec gnome-session
fi
