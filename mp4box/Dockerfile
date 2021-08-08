# https://github.com/gpac/gpac/wiki/GPAC-Build-Guide-for-Linux

FROM ubuntu:18.04

RUN apt update && apt install build-essential pkg-config zlib1g-dev

ARG user
USER $user
WORKDIR /build

RUN ./configure --static-mp4box --prefix=/home/$user/.local && make -j4 && make install

#docker run -it --rm -v $PWD/gpac:/build -v $HOME/.local:$HOME/.local ubuntu:18.04
