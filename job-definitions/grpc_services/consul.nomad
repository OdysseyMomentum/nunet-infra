job "consul" {
    datacenters = ["nunet-io"]

    group "consul" {
        count = 1
        task "consul" {
            driver = "raw_exec"
            
            config {
                command = "consul"
                args = ["agent", "-dev", "-client=0.0.0.0", "-advertise=195.201.197.25"]
            }

        }
    }
}

