#!/bin/bash

set -e

# enable debug mode if desired
if [[ "${DEBUG}" == "true" ]]; then
    set -x
fi
user=${USER:-root}
password=${PASSWORD:-alpine@}
root_password=${ROOT_PASSWORD}

if [[ "$user" != "root" ]]; then
   if ! id -u $user > /dev/null 2>&1; then
      adduser -u 1000 $user -G root -D
      echo "$user:$password" | chpasswd
   fi
fi

if [ -n "$root_password" ]; then
    echo "root:$root_password" | chpasswd
else
    echo "root:$password" | chpasswd
fi
exec /usr/sbin/sshd -D -e "$@"
