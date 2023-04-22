#!/usr/bin/env bash

ORIG_DIR="$PWD"

if (($# < 2))
then
    echo "Usage: switch-gitserver.sh DIR URL"
    exit 1
fi

DIR="$1"
URL="$2"

if [ ! -d "$DIR/.git" ]; then
    echo "'$DIR' is not a git directory."

    cd "$ORIG_DIR"
    exit 1
fi

cd "$DIR"

orig_url=`git config remote.origin.url`
status=$?

if [ 0 -ne $status ]; then
    echo "git config failed with status=$status."

    cd "$ORIG_DIR"
    exit 1
fi

echo "$orig_url" to "$URL"

git config remote.origin.url "$URL"
last_status=$?

if [ 0 -ne $last_status ]; then
    echo "git config (set) failed with status=$last_status."

    cd "$ORIG_DIR"
    exit 1
fi

cd "$ORIG_DIR"
