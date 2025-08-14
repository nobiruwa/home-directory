#!/usr/bin/env bash

if [ "$1" = "right" ]; then
    hdmi_option=( --right-of )
else
    hdmi_option=( --left-of )
fi


# xrandr --output HDMI-0 --mode 1920x1080
xrandr --output DP-1 --mode 1920x1080 "${hdmi_option[@]}" HDMI-0
