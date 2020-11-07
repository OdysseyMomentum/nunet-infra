log_level="DEBUG"

datacenter = "nunet-io"
data_dir  = "/etc/nunet-adapter/server"

bind_addr = "0.0.0.0" # the default

advertise {
  # Defaults to the first private IP address.
  # http = "1.2.3.4"
  # rpc  = "1.2.3.4"
  # serf = "1.2.3.4:5442" # non-default ports may be specified
}

server {
  enabled = true
  bootstrap_expect = 1
}

