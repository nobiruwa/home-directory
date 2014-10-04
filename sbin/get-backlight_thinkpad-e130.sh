#!/bin/sh

CURRENT_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/brightness)
MAX_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/max_brightness)

BRIGHTNESS_PERCENT=$(expr 100 "*" $CURRENT_BRIGHTNESS / $MAX_BRIGHTNESS)

echo "brightness=$CURRENT_BRIGHTNESS (${BRIGHTNESS_PERCENT}%)"
