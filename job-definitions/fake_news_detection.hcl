job "fake_news_detection" {
    datacenters = ["nunet-io"]
    type = "service"
    group "fake_news_detection" {
        count = 1
        network {
            port "TALOS_GRPC_PORT" {}
            port "UCL_GRPC_PORT" {}
        }
        task "fake_news_score" {
            driver = "docker"
            config {
                image = "registry.gitlab.com/nunet/fake-news-detection/fake_news_score/fake_news_score_module:latest"
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
                command = "python3.5"
                args = ["/root/uclnlp/pred.py", "serve", "grpc"]                
                ports = ["UCL_GRPC_PORT"]
            }
            logs {
                max_files = 10
                max_file_size = 15
            }
            resources {
                cpu = 5000
                memory = 7000
            }
        }
    }
}

