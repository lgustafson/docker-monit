FROM phusion/baseimage:0.9.13

MAINTAINER Leif Gustafson <leif@leifgustafson.com>

ENV HOME /root

CMD ["/sbin/my_init"]

EXPOSE 2812

ADD install-monit.sh /root/install-monit.sh
RUN /root/install-monit.sh && \
  install -o monit -g monit -m 0750 -d /home/monit/conf

ADD monitrc /home/monit/conf/monitrc
RUN chown monit:monit /home/monit/conf/monitrc && \
  chmod 0700 /home/monit/conf/monitrc && \
  install -o monit -g monit -m 0750 -d /home/monit/conf/monitrc.d \
    /home/monit/conf/monit.d

ADD 001-daemon.conf /home/monit/conf/monitrc.d/
ADD 002-http.conf /home/monit/conf/monitrc.d/

RUN mkdir /etc/service/monit
ADD monit.sh /etc/service/monit/run

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
