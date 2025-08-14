#!/usr/bin/env bash

# Network
DEVICE_NAME=vpn_softvpn
ADDRESS=192.168.30.10
MASK=24
NETWORK_ADDRESS=192.168.30.0/24

routes=`ip route | egrep ${DEVICE_NAME}`

while IFS= read -r line
do
  if [[ $line =~ ([0-9\.\/]+) ]]; then
    network_address=${BASH_REMATCH[1]}
    echo delete route ${network_address}
    sudo ip route delete ${network_address}
  fi
done <<< "$routes"

sudo ip addr del ${ADDRESS}/${MASK} dev ${DEVICE_NAME}

# SoftEther
vpncmd /client localhost /cmd AccountDisconnect softaccount

exit 0
