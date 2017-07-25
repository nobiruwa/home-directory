#!/bin/sh

xrandr --output LVDS-1 --mode 1366x768
xrandr --output HDMI-1 --mode 1280x720 --left-of LVDS-1
