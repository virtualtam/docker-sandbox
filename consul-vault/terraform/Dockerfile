FROM hashicorp/terraform:0.12.20

RUN addgroup -S -g 1000 terraform \
    && adduser \
        -s /bin/sh \
        -h /home/terraform \
        -u 1000 \
        -g "Terraform user" \
        -G terraform \
        -S \
        terraform

USER terraform
WORKDIR /home/terraform

ENTRYPOINT ["/bin/sh"]
