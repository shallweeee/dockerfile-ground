#! /bin/bash

DOCKER_IMAGE=maven
LOC_M2_REPO=$HOME/.m2/repository
DOC_M2_REPO=/root/.m2/repository
JASYPT_DIR=~/.local/jasypt
JASYPT_VER=1.9.3
OPTS='verbose=false'

usage() {
  echo "usage: ${0##*/} [-v] <enc|dec> <params>"
  exit
}

download_jasypt() {
  [ -f "$JASYPT_DIR"/bin/encrypt.sh ] && return

  mkdir -p "$JASYPT_DIR"
  pushd "$(dirname "$JASYPT_DIR")"
  wget https://github.com/jasypt/jasypt/releases/download/jasypt-$JASYPT_VER/jasypt-$JASYPT_VER-dist.zip &&
  7z x jasypt-$JASYPT_VER-dist.zip &&
  rm jasypt-$JASYPT_VER-dist.zip 
  popd
}

# main
while getopts 'v' opt; do
  case $opt in
    v) OPTS= ;;
    *) usage ;;
  esac
done
shift $((OPTIND - 1))

case $1 in
  enc) CMD=bin/encrypt.sh ;;
  dec) CMD=bin/decrypt.sh ;;
  *) usage ;;
esac
shift

docker run --rm -it -v $LOC_M2_REPO:$DOC_M2_REPO -v "$JASYPT_DIR":/app $DOCKER_IMAGE /app/$CMD "$@" $OPTS
