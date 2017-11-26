#!/bin/sh

NEW_BRIGHTNESS_PERCENT=$1 # 1% to 100%
if [ -z $NEW_BRIGHTNESS_PERCENT ]; then
    NEW_BRIGHTNESS_PERCENT=100
fi

echo $NEW_BRIGHTNESS_PERCENT
TARGET_FILE=/sys/class/backlight/intel_backlight/brightness
MAX_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/max_brightness)
echo $NEW_BRIGHTNESS_PERCENT $MAX_BRIGHTNESS

if test 0 -lt $NEW_BRIGHTNESS_PERCENT && test 100 -ge $NEW_BRIGHTNESS_PERCENT ; then
    if test -e $TARGET_FILE ; then
        # not forget divide by 100
        NEW_BRIGHTNESS=$(expr $NEW_BRIGHTNESS_PERCENT "*" $MAX_BRIGHTNESS / 100)
        echo "brightness=$NEW_BRIGHTNESS (${NEW_BRIGHTNESS_PERCENT}% of $MAX_BRIGHTNESS)"
        echo $NEW_BRIGHTNESS >  $TARGET_FILE
    fi
fi
