FROM golang:1.19-alpine

ENV LISTEN_PORT 8080
ENV CGO_ENABLED 0

RUN apk add --update --no-cache git \
    && git clone https://github.com/prometheus/client_golang.git \
    && cd client_golang/examples/random \
    && go build \
    && cp random /usr/local/bin/random

ADD docker-entrypoint.sh /usr/local/bin/

CMD ["docker-entrypoint.sh"]
