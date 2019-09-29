#!/bin/bash

set -e

# enable debug mode if desired
if [[ "${DEBUG}" == "true" ]]; then
    set -x
fi
USER=${USER:-root}
PASSWORD=${PASSWORD:-alpine@}
ROOT_PASSWORD=${ROOT_PASSWORD}

LANG="${LANG:-zh_CN}.UTF-8"

echo "LANG=$LANG" >> /etc/profile
echo "LANGUAGE=$LANG" >> /etc/profile
echo "LC_ALL=$LANG" >> /etc/profile
source /etc/profile

if [[ "$USER" != "root" ]]; then
   if ! id -u $USER > /dev/null 2>&1; then
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
