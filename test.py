import nomad
import logging
import json

loggers = {}
NOMAD_HOST = "localhost"

def setup_custom_logger(name, log_level=logging.DEBUG):
    if loggers.get(name):
        return loggers[name]

    logger = logging.getLogger(name)
    loggers[name] = logger

    formatter = logging.Formatter(fmt='%(asctime)s - %(levelname)s - %(module)s - line %(lineno)d - %(message)s')
    handler = logging.StreamHandler()
    handler.setFormatter(formatter)
    logger.setLevel(log_level)
    logger.addHandler(handler)
    return logger

logger = setup_custom_logger('root')

# checking if nomad is running
n = nomad.Nomad(host=NOMAD_HOST, timeout=5)
status = n.status
logger.info("Nomad status is %s" % status)

# get the job definition from file
file = open("./job-definitions/fake_news_detection.json")
job_definition = json.load(file)

#spinning the fake_news_detector workflow
register = n.job.register_job("fake_news_detector", job_definition)
logger.debug("Registered job %s" % register)
deployment = n.job.get_deployment("fake_news_detector")
logger.debug("Deployments: %s" % deployment)

# getting the result

# deregistering the job
#n.job.deregister_job("fake_news_detector")

