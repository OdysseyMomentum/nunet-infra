job "fake_news_detector" {
    datacenters = ["nunet-io"]
    type = "service"
    group "fake_news_detector" {
        count = 1
        network {
            port "TALOS_GRPC_ADD" {}
            port "UCL_GRPC_ADD" {}
        }
        restart {
            interval = "30m"
            attempts = 2
            delay    = "15s"
            mode     = "fail"
        }
        task "fake_news_score" {
            driver = "docker"
            config {
                image = "registry.gitlab.com/nunet/fake-news-detection/fake_news_score/fake_news_score_module"
                ports = ["TALOS_GRPC_ADD", "UCL_GRPC_ADD"]
                command = "python3"
                args = ["fake_news_score.py"]
            }
            logs {
                max_files = 10
                max_file_size = 15
            }
            resources {
                cpu = 200
                memory = 256
            }
        }
        task "uclnlp" {
            driver = "docker"
            config {
                image = "registry.gitlab.com/nunet/fake-news-detection/uclnlp/uclnlp_module:latest"
                ports = ["UCL_GRPC_ADD"]
            }
            logs {
                max_files = 10
                max_file_size = 15
            }
            resources {
                cpu = 500
                memory = 500
            }
        }
    }
}

