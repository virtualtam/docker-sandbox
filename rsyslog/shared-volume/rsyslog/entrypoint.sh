#!/bin/bash
PIDFILE="/run/rsyslogd.pid"
rm -f ${PIDFILE}
exec rsyslogd -n -i "${PIDFILE}"
