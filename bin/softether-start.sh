#!/usr/bin/env bash

# SoftEther
vpncmd /client localhost /cmd AccountConnect softaccount

# Network
DEVICE_NAME=vpn_softvpn
ADDRESS=192.168.30.10
MASK=24
NETWORK_ADDRESS=192.168.30.0/24

sudo ip addr add ${ADDRESS}/${MASK} dev ${DEVICE_NAME}

sudo ip route add ${NETWORK_ADDRESS} via ${ADDRESS} dev ${DEVICE_NAME}

exit 0
