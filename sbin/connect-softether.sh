#!/usr/bin/env bash

# rootでの実行のみを許可します
if [[ $(id -u) -ne 0 ]] ; then
    echo "Please run as root."
    exit 1
fi

# softeher-vpnclientが起動済みでない場合はただちに終了します
VPNCLIENT_RUNNING=$(systemctl is-active --quiet softether-vpnclient)

if [ ${VPNCLIENT_RUNNING} -ne 0 ]; then
    echo "Cannot execute, because softehter-vpnclient is not running."
    exit 1
fi

# SoftEtherのクライアントとして仮想HUBに接続します
# 接続が確立されている場合は処理をスキップします
HUB_NAME="vpn"
CONNECTION_NMAE="vpnconn"
LOG_PATH="/tmp/${USER}-vpncmd-connect.txt"

VPNCMD_ACCOUNT_STATUS_GET=`vpncmd localhost /Client /HUB:"${HUB_NAME}" /CMD AccountStatusGet "${CONNECTION_NMAE}"`

VPNCMD_ACCOUNT_SESSION_STATUS=`echo "${VPNCMD_ACCOUNT_STATUS_GET}" | egrep "^Session Status"`

if [[ "${VPNCMD_ACCOUNT_SESSION_STATUS}" == *"Connection Completed"* ]]; then
    echo "Skip to connect, because the connection has already established."
else
    vpncmd localhost /Client /OUT:"${LOG_PATH}" /HUB:"${HUB_NAME}" /CMD AccountConnect "${CONNECTION_NMAE}"
    VPNCMD_EXIT_CODE=$?
fi

# 仮想NICに静的IPアドレスを割り当てます
# IPアドレスが割り当てられている場合は処理をスキップします
VIRTUAL_DEVICE_NAME="vpn_vpn0"
IP_ADDRESS="192.168.30.2/24"
IP_DEFAULT_GATEWAY="192.168.30.2"

IP_ADDR=`ip -o -4 addr list "${VIRTUAL_DEVICE_NAME}"`

if [[ "${IP_ADDR}" == *"${IP_ADDRESS}"* ]]; then
    echo "Skip to set an IP address, because the device has already had the IP address."
else
    ip addr add "${IP_ADDRESS}" dev "${VIRTUAL_DEVICE_NAME}"
    ip route add "${IP_ADDRESS}" via "${IP_DEFAULT_GATEWAY}" dev "${VIRTUAL_DEVICE_NAME}"
fi
