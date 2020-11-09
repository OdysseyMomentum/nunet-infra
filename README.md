# nunet-infra prototype

This is based on nomad. Should work as follows:

## step 1

The nomad installation is controlled via `adapter.sh` script, which:

* `sh adapter.sh install` downloads and installs newest nomad, installs configuration on the system, etc. requires `sudo`;
* `sh adapter.sh start dev` sarts nomad agent in dev mode (i.e. single server and single client);
* `sh adapter.sh start server` and `sh adapter.sh start client` was supposed to start server and client separately in production but apparently that needs more than one server...
* `sh adapter.sh status` shows the status of nomad agent;
* `sh adapter.sh stop dev` -- stops nomad agent;

## step 2

There are two ways to deploy a test network made of *fake_news_score* and *uclnlp* docker modules:

* `nomad job run job-definitions/fake_news_detection.hcl` allocates the job into nomad manually;
* `python test.py` does exactly the same but from python interface. This will be integrated into containers that will do orchastration;

## step 3

Check how things work by looking to `http://localhost:4646/ui/jobs`