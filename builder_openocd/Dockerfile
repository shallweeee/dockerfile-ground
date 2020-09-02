FROM ubuntu:20.04

ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y \
	make \
	libtool \
	pkg-config \
	autoconf \
	automake \
	texinfo \
	libusb-1.0.0-dev \
	git

RUN git clone https://git.code.sf.net/p/openocd/code /sources/openocd

RUN cd /sources/openocd && ./bootstrap && ./configure --prefix=/usr/local && make -j8

ENTRYPOINT ["make", "-C", "/sources/openocd", "install"]
