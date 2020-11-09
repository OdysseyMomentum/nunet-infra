log_level="DEBUG"

datacenter = "nunet-io"
data_dir  = "/etc/nunet-adapter/dev"

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

client {
  enabled       = true
  gc_interval = "1h"
  gc_max_allocs = 100
  gc_disk_usage_threshold = 85
  servers = ["127.0.0.1:4647"]
  options {
    "docker.cleanup.image" = "false"
  }
}

plugin "docker" {
  config {
    gc {
      dangling_containers {
        enabled = false
      }
    }
  }
}