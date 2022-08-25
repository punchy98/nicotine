LABEL org.opencontainers.image.authors="Michael Maldonado"

FROM ghcr.io/linuxserver/baseimage-rdesktop-web
#update and install necessary packages
RUN apt -yy update \
&& apt -yq install software-properties-common \
&& add-apt-repository ppa:nicotine-team/stable \
&& apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6CEB6050A30E5769 \
&& apt update -yy \
&& apt install -yq nicotine

#Cleanup
RUN apt clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Set perms
RUN addgroup nicotine
RUN useradd -s /bin/bash -m -g nicotine nicotine
RUN echo "nicotine:nicotine" | /usr/sbin/chpasswd
RUN echo "nicotine    ALL=(ALL) ALL" >> /etc/sudoers

RUN nicotine
WORKDIR /home/nicotine
USER root

#Set port for connecting
EXPOSE 5900
