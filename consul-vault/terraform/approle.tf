resource "vault_auth_backend" "approle" {
  path = "approle"
  type = "approle"
}
