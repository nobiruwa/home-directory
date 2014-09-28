USE_SESSION=awesome
export LANG=en_US.UTF-8

xset -b

if test $HOME/.Xresources; then
    xrdb -merge $HOME/.Xresources
fi

xset r rate 250 30
# Make Caps Lock a Control key
setxkbmap -layout us -option ctrl:nocaps

is_jp_keybd=`setxkbmap -print|grep -o pc105`
if [ "x" = "x$is_jp_keybd" ]; then
    echo "You're using US keyboard..." # JPキーボードでない
else
    xkbcomp $HOME/.xkb/modifier.xkb $DISPLAY 2>&1 > /dev/null
fi

#$HOME/.dropbox-dist/dropboxd &
emacs-urxvt &

# execute awesome
if test $USE_SESSION = awesome; then 
    exec awesome
fi
# execute gnome-session
if test $USE_SESSION = gnome-session; then
    exec gnome-session
fi
