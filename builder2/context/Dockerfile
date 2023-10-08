ARG VERSION=latest
FROM ubuntu${VERSION}

RUN useradd -m -s /bin/bash builder

RUN apt-get update
# nginx
RUN apt-get install -y build-essential libpcre3 libpcre3-dev zlib1g zlib1g-dev openssl libssl-dev && apt-get clean
# httperf
RUN apt-get install -y automake libtool && apt-get clean

WORKDIR /build
COPY su-exec entrypoint.sh /usr/local/bin
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
