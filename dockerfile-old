FROM ubuntu:latest
MAINTAINER Michael Maldonado
RUN apt -yy update \
&& apt -yq install software-properties-common libx11-6 libx11-xcb1 libfontconfig1 supervisor xvfb x11vnc openbox \
&& add-apt-repository ppa:nicotine-team/stable \
&& apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6CEB6050A30E5769 \
&& apt update -yy \
&& apt install -yq nicotine \
&& apt clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN addgroup nicotine
RUN useradd -s /bin/bash -m -g nicotine nicotine
RUN echo "nicotine:nicotine" | /usr/sbin/chpasswd
RUN echo "nicotine    ALL=(ALL) ALL" >> /etc/sudoers
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN touch /var/log/supervisor/supervisord.log
RUN chown -R nicotine:nicotine /var/log/supervisor/
WORKDIR /home/nicotine
USER root
EXPOSE 5900
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
