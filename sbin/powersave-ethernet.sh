#!/bin/sh

if [ "x$1" != "x" ]; then
    DEVNAME=$1
else
    DEVNAME="eth0"
fi

if [ "x$2" != "x" ]; then
    SPEED=$2
else
    SPEED=10
fi

ethtool -s $DEVNAME autoneg off speed $SPEED
ethtool -s $DEVNAME wol d
