#! /bin/bash

DOCKER_IMAGE=maven
LOC_M2_REPO=$HOME/.m2/repository
DOC_M2_REPO=/root/.m2/repository

usage() {
  echo "usage: ${0##*/} <app directory> [mvn comand]"
  exit
}

# main
[ -f $1/pom.xml ] || usage
APP="$(realpath "$1")"
shift

[ $# -gt 0 ] && CMD="$@" || CMD=install

docker run --rm -it -v $LOC_M2_REPO:$DOC_M2_REPO -v $APP:/app $DOCKER_IMAGE mvn -f /app/pom.xml $CMD
[ $? -eq 0 ] && sudo chown -R $USER:$USER $APP/target
