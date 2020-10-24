#! /bin/bash

usage() {
  echo "usage: ${0##*/} [-i|-c|-h]"
  echo "       -i: remove container and image"
  echo "       -c: remove container"
  echo "       -h: show usage"
  exit
}

NAME=ubuntu
TAG=mine

get_container_image_id() {
  docker container inspect $NAME 2>&1 | awk -F: '/Image": +"sha256/{print $3}' | sed 's/".*//'
}

get_image_id() {
  docker image inspect $NAME:$TAG 2>&1 | awk -F: '/Id": +"sha256/{print $3}' | sed 's/".*//'
}

docker_build() {
  docker build -t $NAME:mine --build-arg=user=$USER .
}

docker_run() {
  docker run -it --name $NAME $NAME:mine bash
}

docker_start() {
  docker start -ai $NAME
}

remove_container() {
  docker stop $NAME 2>/dev/null
  get_container_image_id | grep '.' && docker rm $NAME
  [ x$1 = xnoexit ] || exit
}

remove_image() {
  remove_container noexit
  get_image_id | grep '.' && docker rmi -f $NAME:$TAG
  exit
}

while getopts 'cihv' opt; do
  case $opt in
      c) remove_container ;;
      i) remove_image ;;
    h|*) usage ;;
  esac
done
shift $((OPTIND - 1))

filter=p
get_image_id | grep '.' && filter=''

docker_build | sed -n "$filter" || exit $?

image_id=$(get_image_id)
cont_image_id=$(get_container_image_id)

if [ -z "$cont_image_id" ]; then
  docker_run
elif [ $image_id = $cont_image_id ]; then
  docker_start
else
  echo "Notice: Image was rebuilt, migrate container"
fi
