#!/bin/sh
/usr/sbin/ns-slapd -D /etc/dirsrv/slapd-dir 
tail -F \
    /var/log/dirsrv/slapd-dir/access \
    /var/log/dirsrv/slapd-dir/errors
