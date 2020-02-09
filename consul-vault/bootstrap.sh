#!/bin/bash
#
# Utility functions to bootstrap the Vault cluster and client applications.
#
# These commands are provided to help spin a sandbox environment and SHOULD NOT
# be used on a production cluster.
SEAL_FILE=seal.json

function env-init() {
    # FIXME: use approles for application authentication instead of the root
    # token
    cat <<EOF > .env
VAULT_ROOT_TOKEN=$(jq -r ".root_token" ${SEAL_FILE})
VAULT_UNSEAL_KEY=$(jq -r ".unseal_keys_hex[0]" ${SEAL_FILE})
EOF

    # FIXME: use an approle for Terraform authentication instead of the root
    # token
    jq -r ".root_token" ${SEAL_FILE} > terraform/.vault-token
}

function vault-init() {
    docker-compose exec vault vault operator init -format=json -key-shares=1 -key-threshold=1 > ${SEAL_FILE}
    env-init
}

function vault-unseal() {
    source .env
    docker-compose exec vault vault operator unseal ${VAULT_UNSEAL_KEY}
}

function terraform-init() {
    docker-compose exec terraform terraform init
}

function terraform-apply() {
    docker-compose exec terraform terraform apply
}
