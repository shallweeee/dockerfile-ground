FROM ubuntu:20.04

ARG user
RUN apt update && \
    apt install -y git sudo vim && \
    useradd -ms /bin/bash $user && \
    echo "$user ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
USER $user
WORKDIR /home/$user
