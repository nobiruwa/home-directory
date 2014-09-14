#!/bin/sh

is_jp_keybd=`setxkbmap -print|grep -o pc105`

if [ "x" = "x$is_jp_keybd" ]; then
    exit 0 # JPキーボードでない
else
    xkbcomp $HOME/.xkb/modifier.xkb $DISPLAY 2>&1 > /dev/null
fi
