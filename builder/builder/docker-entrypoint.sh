#! /bin/bash

_check_uid() {
	local uid="$(id -u builder)"
	[ -z "$HUID" ] || [ $uid = "$HUID" ]
}

_modify_uid() {
	usermod -u "$HUID" builder
	chown -R builder /home/builder
}

_check_uid || _modify_uid
if [ x${1##*/build.sh} = xbuild.sh ]; then
  exec gosu builder "$@"
else
  "$@"
fi
