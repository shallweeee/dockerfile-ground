FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python2.7 python-wxgtk3.0 python-twodict \
        wget ca-certificates && \
    wget -q -O dlg.deb http://ppa.launchpad.net/nilarimogard/webupd8/ubuntu/pool/main/y/youtube-dlg/youtube-dlg_0.4-1~webupd8~bionic9_all.deb && \
    dpkg -i dlg.deb && \
    rm -f dlg.deb && \
    find /usr/lib/python2.7 -name '*.pyc' -delete && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget -q -O /usr/local/bin/youtube-dl https://yt-dl.org/downloads/latest/youtube-dl && \
    chmod a+rx /usr/local/bin/youtube-dl

ARG UID
ARG GID
ARG USER
RUN addgroup --gid ${GID} ${USER} && \
    adduser --shell /bin/bash --uid ${UID} --gid ${GID} --gecos "" --disabled-password ${USER}

USER ${USER}
WORKDIR /home/${USER}
RUN mkdir -p .config/youtube-dlg/ && \
    cd .config/youtube-dlg && \
    ln -s /usr/local/bin/youtube-dl youtube-dl

CMD ["/usr/bin/youtube-dl-gui"]
