FROM ubuntu:14.04.2

MAINTAINER Leif Gustafson <leif@leifgustafson.com>

EXPOSE 2812

COPY install-monit.sh /root/install-monit.sh
RUN install -o root -g root -m 0755 -d /opt && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install curl && \
    /root/install-monit.sh && \
    apt-get -y remove curl && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY monitrc /etc/monitrc
COPY 001-daemon.conf /etc/monitrc.d/001-daemon.conf
COPY 002-http.conf /etc/monitrc.d/002-http.conf
RUN chown root:root /etc/monitrc && chmod 0700 /etc/monitrc

CMD [ "/opt/monit/bin/monit", "-c", "/etc/monitrc", "-I" ]
