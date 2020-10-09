FROM ubuntu:latest

RUN apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y \
    sudo \
    dialog \ 
    apt-utils \
    curl

RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER docker

COPY . /quick-wordpress

WORKDIR /quick-wordpress

RUN ./build.sh

CMD ./service-start.sh
