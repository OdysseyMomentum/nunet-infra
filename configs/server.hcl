log_level="DEBUG"

datacenter = "nunet-io"
data_dir  = "/etc/nunet-adapter/server"

bind_addr = "0.0.0.0" # the default

advertise {
  http = "fnc.icog-labs.com:4646"
  rpc  = "fnc.icog-labs.com:4647"
}

server {
  enabled = true
  bootstrap_expect = 1
}

