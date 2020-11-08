{
    "Job": {
       "ID": "fake_news_score",
       "Name": "fake_news_score",
       "Datacenters": ["nunet-io"],
       "TaskGroups": [{
            "Name": "cache",
            "Count": 1,
            "Network":
            "Tasks": [{
                "Name": "fake_news_score",
                "Driver": "docker",
                        "Config": {
                            "Name": "fake_news_score_module",
                            "Driver": "docker",
                            "User": "",
                            "Config": {
                            "image": "registry.gitlab.com/nunet/fake-news-detection/fake_news_score/fake_news_score_module:latest",
                            "command": "echo",
                            "args": ["Success"]
                        },
                        "LogsConfig": {
                            "MaxFiles": 10,
                            "MaxFileSize": 10
                        }
                      }
                    ]
                  }
                ],
                'Update': {'AutoRevert': False,
                           'Canary': 0,
                           'HealthCheck': None,
                           'HealthyDeadline': 180000000000,
                           'MaxParallel': 1,
                           'MinHealthyTime': 10000000000,
                           'Stagger': None
                           },
                'VaultToken': None,
                'Version': None
            }
        }