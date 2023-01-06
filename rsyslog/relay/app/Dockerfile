FROM ubuntu:22.04

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        openssh-server \
        rsyslog \
        supervisor

RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
    && mkdir -p \
        /var/log/custom \
        /var/run/sshd

RUN sed -i '/imklog/s/^/#/' /etc/rsyslog.conf
COPY 60-imuxsock.conf /etc/rsyslog.d/60-imuxsock.conf

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["supervisord"]
