#! /bin/bash

dotenv() {
  cat << EOF > .env
UID=$(id -u)
GID=$(id -g)
USER=$USER
EOF
}

do_exec() {
  [ -z "$1" ] && set -- bash "$@"
  docker exec -it -u root $(docker-compose ps -q) "$@"
}

cd "$(dirname "$(readlink -f "$0")")"
[ -f .env ] || dotenv

case $1 in
  up) docker-compose up -d ;;
  exec) shift
	do_exec "$@" ;;
  *) docker-compose "$@" ;;
esac
