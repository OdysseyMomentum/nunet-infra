job "uclnlp" {
    datacenters = ["nunet-io"]

    group "uclnlp-service" {
        count = 1
        task "uclnlp-grpc" {
            driver = "docker"

            config {
                image = "registry.gitlab.com/nunet/fake-news-detection/uclnlp/uclnlp"
                args = ["python3", "/uclnlp/fakenewschallenge/pred.py", "serve", "grpc", " ${NOMAD_PORT_rpc}"]
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
                name = "uclnlp"
                port = "rpc"

                tags = [
                    "theNunetMachine",
                    "urlprefix-/uclnlp proto=grpc",
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
