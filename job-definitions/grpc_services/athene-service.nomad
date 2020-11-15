job "athene" {
    datacenters = ["nunet-io"]

    group "athene-service" {
        count = 1
        task "athene-system" {
            driver = "docker"

            config {
                image = "registry.gitlab.com/nunet/fake-news-detection/athene/athene_system"
                args = ["/bin/bash", "/root/athene_system/fnc/run.sh", "${NOMAD_PORT_http}"]
            }

            resources {
                cpu    = 2000 # MHz
                memory = 8560 # MB
                network {
                    mbits = 100
                    port "http" {}
                }
            }

            service {
                name = "athene-system"
                port = "http"

                tags = [
                    "theNunetMachine",
                    "urlprefix-/athene-system",
                ]

                check {
                    type     = "script"
                    name     = "check_table"
                    command  = "/bin/echo"
                    args     = ["hello"]
                    interval = "5s"
                    timeout  = "5s"

                    check_restart {
                      limit = 3
                      grace = "90s"
                      ignore_warnings = false
                    }
                }
            }

        }

        task "athene-grpc" {
            driver = "docker"

            config {
                image = "registry.gitlab.com/nunet/fake-news-detection/athene/athene_grpc"
                args = ["python3", "grpc_service.py",
                        "--athene-addr", "http://195.201.197.25:19998/athene-system",
                        "--listen", "${NOMAD_PORT_rpc}"]
            }

            resources {
                cpu    = 2000 # MHz
                memory = 8560 # MB
                network {
                    mbits = 100
                    port "rpc" {}
                }
            }

            service {
                name = "athene"
                port = "rpc"

                tags = [
                    "theNunetMachine",
                    "urlprefix-/athene proto=grpc",
                ]

                check {
                    type     = "script"
                    name     = "dummy"
                    command  = "/bin/echo"
                    args     = ["hello"]
                    interval = "5s"
                    timeout  = "5s"

                    check_restart {
                      limit = 3
                      grace = "90s"
                      ignore_warnings = false
                    }
                }
            }
        }
    }
}
