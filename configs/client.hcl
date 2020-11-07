log_level="DEBUG"

datacenter = "nunet-io"
data_dir = "/etc/nunet-adapter/client"

bind_addr = "0.0.0.0" # the default

client {
  enabled       = true
  gc_interval = "1h"
  gc_max_allocs = 100
  gc_disk_usage_threshold = 85
  servers = ["127.0.0.1:4647"]
}

ports {
	http=5656
}

# Disable the dangling container cleanup to avoid interaction with other clients
plugin "docker" {
  config {
    gc {
      dangling_containers {
        enabled = false
      }
    }
  }
}