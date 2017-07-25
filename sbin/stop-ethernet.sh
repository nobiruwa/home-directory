#!/bin/sh

if [ "x$1" != "x" ]; then
    DEVNAME=$1
else
    DEVNAME="eth0"
fi

ip link set dev $DEVNAME down

