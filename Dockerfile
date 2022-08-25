FROM ghcr.io/linuxserver/baseimage-rdesktop-web:focal


LABEL org.opencontainers.image.authors="michael@maldonado.tech"
LABEL org.opencontainers.image.source="https://github.com/punchy98/nicotine"
LABEL org.opencontainers.image.title="Containerized Nicotine+ instance"
LABEL org.opencontainers.image.description="Containerized Nicotine+ instance"


#update and install necessary packages
RUN apt -yy update \
&& apt -yq install software-properties-common dbus-x11 uuid-runtime \
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

ENV \
    CUSTOM_PORT="5900" \
    GUIAUTOSTART="true" \
    HOME="/home/nicotine" \
    TITLE="Nicotine+" \
    DISPLAY=$DISPLAY
COPY root/ /
#Start run
USER root
CMD /usr/bin/nicotine

#Set port for connecting
EXPOSE 5900
