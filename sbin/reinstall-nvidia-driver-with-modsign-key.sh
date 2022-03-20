#!/usr/bin/env bash

NVIDIA_INSTALLER=$1
NVIDIA_INSTALLER_PATH=`readlink -f "${NVIDIA_INSTALLER}"`

if [ -f "${NVIDIA_INSTALLER_PATH}" ]; then
    MODSIGN_KEY=`ls -1 /usr/share/nvidia/nvidia-modsign-key-*.key  2> /dev/null | head -1`
    MODSIGN_PUBKEY=`ls -1 /usr/share/nvidia/nvidia-modsign-crt-*.der 2> /dev/null | head -1`

    if [ -f "${MODSIGN_KEY}" -a -f "${MODSIGN_PUBKEY}" ]; then
        MODSIGN_KEY_BACKUP=/tmp/`basename "${MODSIGN_KEY}"`
        MODSIGN_PUBKEY_BACKUP=/tmp/`basename "${MODSIGN_PUBKEY}"`

        cp "${MODSIGN_KEY}" "${MODSIGN_KEY_BACKUP}"
        cp "${MODSIGN_PUBKEY}" "${MODSIGN_PUBKEY_BACKUP}"

        "${NVIDIA_INSTALLER_PATH}" --no-questions --no-install-compat32-libs --module-signing-secret-key="${MODSIGN_KEY}" --module-signing-public-key="${MODSIGN_PUBKEY}"

        if [ ! -f "${MODSIGN_KEY}" ]; then
            cp "${MODSIGN_KEY_BACKUP}" "${MODSIGN_KEY}"
        fi

        if [ ! -f "${MODSIGN_PUBKEY}" ]; then
            cp "${MODSIGN_PUBKEY_BACKUP}" "${MODSIGN_PUBKEY}"
        fi
    else
        echo "Neither ${MODSIGN_KEY} nor ${MODSIGN_PUBKEY} found."
        exit 1
    fi
else
    echo "Please specify a nvidia installer as a first argument."
    exit 1
fi
