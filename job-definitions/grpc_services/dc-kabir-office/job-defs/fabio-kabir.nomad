job "fabio" {

    datacenters = ["kabir-desktop"]

    group "fabio" {
        count = 1
        task "fabio" {
            driver = "raw_exec"

            config {
                command = "fabio"
                args = ["-proxy.strategy=rr", "-proxy.addr=:80;proto=http,:18080;proto=grpc"]
            }

            artifact {
                source = "https://github.com/fabiolb/fabio/releases/download/v1.5.14/fabio-1.5.14-go1.15-linux_amd64"
                destination = "local/fabio"
                mode = "file"
            }
        }
    }
}
