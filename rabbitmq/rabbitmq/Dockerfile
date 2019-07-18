FROM rabbitmq:3.7-management-alpine

RUN mkdir -p /var/log/rabbitmq \
    && chown rabbitmq:rabbitmq /var/log/rabbitmq \
    && rabbitmq-plugins enable --offline \
        rabbitmq_event_exchange \
        rabbitmq_shovel \
        rabbitmq_shovel_management

EXPOSE 5672
EXPOSE 15672

VOLUME /var/log/rabbitmq
