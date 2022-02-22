ARG version
FROM ubuntu:$version

ARG user uid
RUN apt update && \
    apt install -y build-essential vim git tig direnv sudo && \
    useradd -m -u $uid -s /bin/bash $user && \
    echo "$user ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $user
WORKDIR /home/$user
CMD ["/bin/bash", "-i"]
