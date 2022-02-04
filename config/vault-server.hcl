ui = true

storage "consul" {
  address = "127.0.0.1:8500"
  path    = "vault/"
}

api_addr = "http://192.168.0.21:8200"

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = true
}
