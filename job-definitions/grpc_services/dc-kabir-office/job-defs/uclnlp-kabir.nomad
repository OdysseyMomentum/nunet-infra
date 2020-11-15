job "uclnlp-kabir" {
    datacenters = ["nunet-io", "kabir-desktop"]

    group "uclnlp-service" {
        count = 3
        task "uclnlp-kabir" {
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
                name = "uclnlp-kabir"
                port = "rpc"

                tags = [
                    "theNunetMachine",
                    "urlprefix-/uclnlp-kabir proto=grpc",
                ]

                check {
                    type     = "script"
                    name     = "check_table"
                    command  = "/bin/echo"
                    args     = ["hello"]
                    interval = "60s"
                    timeout  = "50s"

                }
            }
        }
    }
}
