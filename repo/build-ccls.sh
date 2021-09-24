#!/usr/bin/env bash

CCLS_DIR=$HOME/repo/ccls.git
CCLS_URL=https://github.com/MaskRay/ccls

function clone {
    git clone --depth=1 --recursive "${CCLS_URL}" "${CCLS_DIR}"
}

if [ x"rebuild" = x"$1" ]; then
    if [ -d "${CCLS_DIR}" ]; then
        mv "${CCLS_DIR}" "/tmp/ccls.git.old"
    fi
    clone
fi

if [ ! -d "${CCLS_DIR}" ]; then
    clone
fi

cd "${CCLS_DIR}" && cmake -H. -Brelease -DCMAKE_BUILD_TYPE=Release && cmake --build release

if [ -d "/tmp/ccls.git.old" ]; then
    rm -rf "/tmp/ccls.git.old"
fi
