#! /bin/bash

usage() {
  echo "usage: ${0##*/} [-v version] <source directory>"
  exit
}

. version

[ -d "$1" ] || usage

src=$(readlink -f "$1")
docker run --rm -it -v "$src":/build -w /build -e HUID=$(id -u) -e HGID=$(id -g) builder$BUILDER_VERSION bash
