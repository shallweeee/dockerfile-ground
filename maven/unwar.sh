#! /bin/bash

DOCKER_IMAGE=maven
LOC_M2_REPO=$HOME/.m2/repository
DOC_M2_REPO=/root/.m2/repository

usage() {
  echo "usage: ${0##*/} <path to war>"
  exit
}

# main
[ $# -gt 0 ] || usage

WAR="$(realpath "$1")"
DIR="$(dirname "$WAR")"
FILE="$(basename "$WAR")"
NAME="${FILE%.*}"

docker run --rm -it -v $LOC_M2_REPO:$DOC_M2_REPO -v $DIR:/app -w /app/$NAME $DOCKER_IMAGE jar xvf ../$FILE
[ $? -eq 0 ] && sudo chown -R $USER:$USER $DIR
