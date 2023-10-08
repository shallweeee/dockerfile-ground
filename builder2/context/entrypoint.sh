#! /bin/bash

set -eu

check_id() {
  [ $HUID:$HGID = $(id -u builder):$(id -g builder) ]
}

change_id() {
  usermod -u ${HUID} builder
  groupmod -g ${HGID} builder
  chown -R builder:builder /home/builder
}

check_id || change_id

[ -z "$1" ] && set -- bash
su-exec builder "$@"
