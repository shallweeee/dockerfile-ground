#! /bin/bash -x

_is_host_uid() {
	local ugid="$(id -u tomcat):$(id -g tomcat)"
	local hostugid="$HOSTUID:$HOSTGID"
	[ $hostugid != : ] && [ $hostugid = $ugid ]
}

_change_uid() {
	groupmod -g $HOSTGID tomcat
	usermod -u $HOSTUID tomcat

	mount | grep /usr/local/tomcat | awk '{print $3}' | xargs chown tomcat:tomcat
}

if ! _is_host_uid; then
	_change_uid
fi

exec /usr/local/bin/docker-entrypoint.sh "$@"
