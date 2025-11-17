FROM golang:1.25-alpine3.22 AS builder

ENV CGO_ENABLED=0

RUN apk add git
RUN git clone --depth=1 https://github.com/prometheus/client_golang.git

WORKDIR /go/client_golang/examples/random
RUN go build -trimpath

FROM scratch

COPY --from=builder /go/client_golang/examples/random/random /random

EXPOSE 8080
ENTRYPOINT ["/random", "-listen-address", ":8080" ]
