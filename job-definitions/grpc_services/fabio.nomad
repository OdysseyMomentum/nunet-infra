job "fabio" {

    datacenters = ["nunet-io"]

    group "fabio" {
        count = 1
        task "fabio" {
            driver = "raw_exec"

            config {
                command = "fabio"
                args = ["-proxy.strategy=rr", "-proxy.addr=:19999;proto=grpc,:19998;proto=http"]
            }

            artifact {
                source = "https://github.com/fabiolb/fabio/releases/download/v1.5.14/fabio-1.5.14-go1.15-linux_amd64"
                destination = "local/fabio"
                mode = "file"
            }
        }
    }
}

