#!/bin/bash

set -e

# enable debug mode if desired
if [[ "${DEBUG}" == "true" ]]; then
    set -x
fi
USER=${USER:-root}
PASSWORD=${PASSWORD:-alpine@}

if [[ "$USER" != "root" ]]; then
    adduser -u 1000 $USER -G root
fi

echo "$USER:$PASSWORD" | chpasswd
exec /usr/sbin/sshd -D -e "$@"
