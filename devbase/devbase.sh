#! /bin/bash

TAG=devbase
VER=18.04

build() {
  docker build -t $TAG:$VER --build-arg=version=$VER --build-arg=user=$USER --build-arg=uid=$UID .
}

run() {
  docker run -it --rm -h $TAG -v $HOME:$HOME -w $PWD $TAG:$VER
}

usage() {
  echo "usage: ${0##*/} <build | run>"
  echo
  exit
}

case $1 in
  build) shift; build "$@";;
  run) shift; run "$@";;
  *) usage;;
esac
