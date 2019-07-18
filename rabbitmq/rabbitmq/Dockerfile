FROM rabbitmq:3.7-management-alpine

ENV EXPORTER_DL_URL https://github.com/deadtrickster/prometheus_rabbitmq_exporter/releases/download/v3.7.2.3

RUN mkdir -p /opt/rabbitmq/plugins \
    && cd /opt/rabbitmq/plugins \
    && wget ${EXPORTER_DL_URL}/accept-0.3.3.ez \
    && wget ${EXPORTER_DL_URL}/prometheus-3.5.1.ez \
    && wget ${EXPORTER_DL_URL}/prometheus_cowboy-0.1.4.ez \
    && wget ${EXPORTER_DL_URL}/prometheus_httpd-2.1.8.ez \
    && wget ${EXPORTER_DL_URL}/prometheus_process_collector-1.3.1.ez \
    && wget ${EXPORTER_DL_URL}/prometheus_rabbitmq_exporter-3.7.2.3.ez

RUN mkdir -p /var/log/rabbitmq \
    && chown rabbitmq:rabbitmq /var/log/rabbitmq \
    && rabbitmq-plugins enable --offline \
        prometheus_rabbitmq_exporter \
        rabbitmq_event_exchange \
        rabbitmq_shovel \
        rabbitmq_shovel_management

EXPOSE 5672
EXPOSE 15672

VOLUME /var/log/rabbitmq
