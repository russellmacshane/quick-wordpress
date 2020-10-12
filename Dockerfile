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

COPY . /home/docker/quick-wordpress

WORKDIR /home/docker/quick-wordpress

RUN sudo chown -R docker:docker /home/docker/quick-wordpress/

RUN ./build.sh

ENTRYPOINT ["./service-start.sh"]
