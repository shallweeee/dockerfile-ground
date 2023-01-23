#! /bin/bash

GIT_REPOSITORY="https://github.com/gpac/gpac.git"
CONFIG_OPTIONS="--static-bin"
MAKE_OPTIONS="-j16"

IMAGE=builder
WORKDIR=/build
SCRIPT=build.sh
#SRC=src
SRC=virt-viewer

build_mp4box() {
  cat << EOF > $SCRIPT
#! /bin/bash
"\$@"
./configure $CONFIG_OPTIONS && make $MAKE_OPTIONS
EOF
}

build_virt_viewer() {
  cat << EOF > $SCRIPT
#! /bin/bash
apt update
apt install ninja-build python3-pip libglib2.0-dev libgtk-3-dev libxml2-dev gettext
pip install meson
meson setup builddir
meson compile -C builddir
EOF
}

if [ -d $SRC ]; then
  (cd $SRC; git pull)
else
  git clone $GIT_REPOSITORY $SRC
fi

build_virt_viewer
chmod u+x $SCRIPT

#docker run --rm -it -w $WORKDIR -v $PWD/$SRC:$WORKDIR -v $PWD/$SCRIPT:/usr/bin/$SCRIPT $IMAGE $SCRIPT "$@"
#rm -f $SCRIPT
docker run --rm -it -w $WORKDIR -v $PWD/$SRC:$WORKDIR -v $PWD/$SCRIPT:/usr/bin/$SCRIPT $IMAGE bash
