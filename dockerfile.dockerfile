FROM ubuntu:latest
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:nicotine-team/stable
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6CEB6050A30E5769
RUN apt update -y
RUN apt install -y nicotine
RUN addgroup nicotine
RUN useradd -s /bin/bash -m -g nicotine nicotine
RUN echo "nicotine:nicotine" | /usr/sbin/chpasswd
RUN echo "nicotine    ALL=(ALL) ALL" >> /etc/sudoers
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN touch /var/log/supervisor/supervisord.log
RUN chown -R nicotine:nicotine /var/log/supervisor/
WORKDIR /home/nicotine
USER nicotine
EXPOSE 5900
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]