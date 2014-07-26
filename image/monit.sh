#!/bin/sh

# Runs as user 'monit'
exec /sbin/setuser monit /opt/monit/bin/monit -I \
  -c /home/monit/conf/monitrc >>/var/log/monit.log 2>&1
