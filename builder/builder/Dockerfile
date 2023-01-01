ARG osver=22.04
FROM ubuntu:$osver

RUN apt-get update && \
    apt-get install -y build-essential pkg-config zlib1g-dev git gosu && \
    apt-get clean && \
    useradd -m -s /bin/bash builder

WORKDIR /build

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
