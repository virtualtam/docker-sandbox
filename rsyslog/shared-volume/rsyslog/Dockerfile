FROM ubuntu:22.04

RUN apt-get update \
    && apt-get install --no-install-recommends -y rsyslog

RUN sed -i '/imklog/s/^/#/' /etc/rsyslog.conf

COPY 60-docker.conf /etc/rsyslog.d/60-docker.conf

VOLUME /var/log
VOLUME /run/rsyslog/dev

COPY entrypoint.sh /usr/local/bin/docker-entrypoint

CMD ["docker-entrypoint"]
