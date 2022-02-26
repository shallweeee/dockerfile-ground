#! /bin/bash

_is_host_uid() {
	local ugid="$(id -u mysql):$(id -g mysql)"
	local hostugid="$HOSTUID:$HOSTGID"
	[ $hostugid != : ] && [ $hostugid = $ugid ]
}

_change_uid() {
	groupmod -g $HOSTGID mysql
	usermod -u $HOSTUID mysql

	chown -R mysql:mysql /var/lib/mysql /var/run/mysqld
}

if ! _is_host_uid; then
	_change_uid
fi

exec /usr/local/bin/docker-entrypoint.sh "$@"
