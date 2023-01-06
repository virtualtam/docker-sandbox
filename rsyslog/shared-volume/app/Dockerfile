FROM ubuntu:22.04

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        openssh-server \
        supervisor

RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
    && mkdir -p \
        /var/log/custom \
        /var/run/sshd

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY entrypoint.sh /usr/local/bin/docker-entrypoint

VOLUME /run/rsyslog/dev

CMD ["docker-entrypoint"]
