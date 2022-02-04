datacenter  = "dc1"
data_dir    = "/opt/consul"
client_addr = "0.0.0.0"
retry_join  = ["192.168.0.21", "192.168.0.19", "192.168.0.20"]

ports {
}

addresses {
}

ui               = true
server           = true
bootstrap_expect = 3
