#!/usr/bin/env bash

# exit code:
#  01 - illegal arguments
for OPT in "$@"; do
    case "$OPT" in
        '--rulesdir' )
            if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
                exit 1
            fi
            RULESDIR=`readlink -f $2`
            RULESDIR_WINDOWS=`cygpath -w "$RULESDIR"`
            PARAMS+=( '--rulesdir', $RULESDIR_WINDOWS )
            shift 2
            ;;
        '--stdin-filename' )
            if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
                exit 1
            fi
            STDIN_FILENAME=`readlink -f $2`
            STDIN_FILENAME_WINDOWS=`cygpath -w "$STDIN_FILENAME"`
            PARAMS+=( '--stdin-filename', $STDIN_FILENAME_WINDOWS )
            shift 2
            ;;
        *)
            PARAMS+=( "$1" )
            shift 1
            ;;
    esac
done

STDIN_FILENAME_WINDOWS=$(echo $STDIN_FILENAME_WINDOWS | sed -e 's/\\/\\\\/g')
eslint "${PARAMS[@]}" | sed -e "s,$STDIN_FILENAME_WINDOWS,$STDIN_FILENAME,"
