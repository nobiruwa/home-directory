#!/usr/bin/env bash

function shallow-search() {
    search_result=`find "${CURRENT_SEARCH_DIR}" -mindepth 1 -maxdepth 1 | grep -v ".git$" | sort`
}

function deep-search() {
    search_result=`find "${CURRENT_SEARCH_DIR}" -mindepth 1 | grep -v ".git$" | sort`
}

SEARCH_DIR=${1:-.}

if [ "${SEARCH_DIR}" = "." ]; then
    echo '*'
    prev=asterisk

    CURRENT_SEARCH_DIR="${SEARCH_DIR}"
    shallow-search
    top_children=$search_result

    for child in $top_children; do

        if [ -L "$child" -o -f "$child" ]; then
            if [ "$prev" != "file" ]; then
                echo ''
            fi

            echo "$child" | sed -e 's|^\./|!|'

            prev=file
            continue
        else
            echo ''
            echo "$child" | sed -e 's|^\./|!|'

            CURRENT_SEARCH_DIR="$child"
            deep-search
            echo "$search_result" | sed -e 's|^\./|!|'

            prev=directory
        fi
    done
else
    echo "${SEARCH_DIR}" | sed -e 's|^|!|' | sed -e 's|\/$||'

    CURRENT_SEARCH_DIR="${SEARCH_DIR}"
    deep-search
    echo "$search_result" | sed -e 's|^|!|'
fi


