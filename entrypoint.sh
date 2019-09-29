#!/bin/bash

set -e

# enable debug mode if desired
if [[ "${DEBUG}" == "true" ]]; then
    set -x
fi
USER=${USER:-root}
PASSWORD=${PASSWORD:-alpine@}
ROOT_PASSWORD=${ROOT_PASSWORD}

if [[ "$USER" != "root" ]]; then
   id $user >& /dev/null
   if [ $? -ne 0 ]; then
      adduser -u 1000 $USER -G root -D
      echo "$USER:$PASSWORD" | chpasswd
   fi
fi

if [ -n "$ROOT_PASSWORD" ]; then
    echo "root:$ROOT_PASSWORD" | chpasswd
else
    echo "root:$PASSWORD" | chpasswd
fi
exec /usr/sbin/sshd -D -e "$@"
