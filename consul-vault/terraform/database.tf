variable "postgres_ro_role_name" {
  default = "readonly"
}

resource "vault_mount" "database" {
  path = "database"
  type = "database"
}

resource "vault_database_secret_backend_role" "postgres_ro" {
  backend             = vault_mount.database.path
  name                = var.postgres_ro_role_name
  db_name             = vault_database_secret_backend_connection.postgres.name
  creation_statements = split("\n", trimspace(file("readonly.sql")))
}

resource "vault_database_secret_backend_connection" "postgres" {
  backend       = vault_mount.database.path
  name          = "postgres"
  allowed_roles = [var.postgres_ro_role_name]

  postgresql {
    # FIXME: rotate root credentials
    # FIXME: do not expose initial credentials
    connection_url = "postgres://root:rootpassword@postgres:5432/vaulthunter?sslmode=disable"
  }
}

resource "vault_policy" "apps" {
  name   = "apps"
  policy = file("apps-policy.hcl")
}
