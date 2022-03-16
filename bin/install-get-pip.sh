#!/usr/bin/env bash

INSTALL_DIR="$HOME/bin"
DESTINATION_PATH="${INSTALL_DIR}/get-pip.py"

mkdir -p "${INSTALL_DIR}"

wget https://bootstrap.pypa.io/get-pip.py -O "${DESTINATION_PATH}"

chmod +x "${DESTINATION_PATH}"
