log_level = "DEBUG"

data_dir = "/tmp/client_anton"

name = "kabir-desktop"

datacenter = "kabir-desktop"

client {
    enabled = true
    servers = ["fnc.icog-labs.com:4647"]
}

plugin "raw_exec" {
  config {
    enabled = true
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

