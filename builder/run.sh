#! /bin/bash

GIT_REPOSITORY="https://github.com/gpac/gpac.git"
CONFIG_OPTIONS="--static-bin"
MAKE_OPTIONS="-j16"

IMAGE=builder
WORKDIR=/build
SCRIPT=build.sh
SRC=src

if [ -d $SRC ]; then
  (cd $SRC; git pull)
else
  git clone $GIT_REPOSITORY $SRC
fi

cat << EOF > $SCRIPT
#! /bin/bash
"\$@"
./configure $CONFIG_OPTIONS && make $MAKE_OPTIONS
EOF
chmod u+x $SCRIPT

docker run --rm -it -w $WORKDIR -v $PWD/$SRC:$WORKDIR -v $PWD/$SCRIPT:/usr/bin/$SCRIPT $IMAGE $SCRIPT "$@"
rm -f $SCRIPT
