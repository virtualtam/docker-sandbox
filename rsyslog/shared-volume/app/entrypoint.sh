#!/bin/sh
ln -sf /var/run/rsyslog/dev/log /dev/log

exec /usr/bin/supervisord
