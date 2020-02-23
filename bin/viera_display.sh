#!/usr/bin/env bash

if [ "$1"="right" ]; then
    hdmi_option=( --right-of )
else
    hdmi_option=( --left-of )
fi


xrandr --output LVDS-1 --mode 1366x768
xrandr --output HDMI-1 --mode 1280x720 "${hdmi_option[@]}" LVDS-1
