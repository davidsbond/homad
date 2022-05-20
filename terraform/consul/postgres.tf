resource "consul_key_prefix" "postgres" {
  path_prefix = "homad/postgres/"
  subkeys = {
    "POSTGRES_DB" = "postgres"
    "PGDATA"      = "/data"
  }
}
