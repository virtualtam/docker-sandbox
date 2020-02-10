#!/bin/bash
#
# Utility functions to bootstrap the Vault cluster and client applications.
#
# These commands are provided to help spin a sandbox environment and SHOULD NOT
# be used on a production cluster.

# Vault information, unseal keys, tokens and leases are written to JSON files
# for convenience.
#
# You MUST NOT do this on a production cluster!
SEAL_FILE=seal.json
PG_LEASE_FILE=postgres_lease.json

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

function vault-postgres-obtain-lease() {
    source .env
    docker-compose exec vault vault read -format=json database/creds/readonly > ${PG_LEASE_FILE}
}

function terraform-init() {
    docker-compose exec terraform terraform init
}

function terraform-apply() {
    docker-compose exec terraform terraform apply
}

function psql-root() {
    docker-compose exec postgres psql -U root vaulthunter
}

function psql-root-list-users() {
    docker-compose exec postgres psql -U root vaulthunter -c "\\du"
}
