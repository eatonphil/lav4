#!/usr/bin/env bash

set -e -u

API_ROOT="https://api.alpha.linode.com/v4"

ARGS=("$@") # Must be quoted for quotes in args with spaces to parse correctly
LAST_INDEX=$(($#-1))

if [[ "${ARGS[$LAST_INDEX]}" != /* ]]; then
    echo "Last argument must be endpoint. ex: /linode/instances"
    echo "Got ${ARGS[$LAST_INDEX]}"
    exit 1
fi

ARGS[$LAST_INDEX]="${API_ROOT}${ARGS[$LAST_INDEX]}"

$(which curl) -H "Authorization: token $(cat ~/.lav4)" "${ARGS[@]}"
