FROM ubuntu:22.04

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        rsyslog \
        tree

RUN sed -i '/imklog/s/^/#/' /etc/rsyslog.conf \
    && mkdir -p /var/log/remotelogs \
    && chown -R syslog:syslog /var/log/remotelogs

COPY 60-imtcp.conf /etc/rsyslog.d/60-imtcp.conf

VOLUME /var/log
VOLUME /run/rsyslog/dev

COPY entrypoint.sh /usr/local/bin/docker-entrypoint

CMD ["docker-entrypoint"]
