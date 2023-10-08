#! /bin/bash

usage() {
  echo "usage: ${0##*/} [-v version]"
  exit
}

. version

docker build --build-arg VERSION=$BUILDER_VERSION -t builder$BUILDER_VERSION context
