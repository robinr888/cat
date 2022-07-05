
from flask import Flask
from prometheus_flask_exporter import PrometheusMetrics
import logging
import random
import json
import configparser
import os


try:
    deployEnv = os.getenv('Environment')
    configfile = deployEnv + "config.ini"
except:
    deployEnv = "devconfig.ini"

config = configparser.ConfigParser()
config.read(deployEnv)

if not os.getenv('DEBUG_METRICS'):
    os.environ["DEBUG_METRICS"] = config["default"]["PromethuesMetrics"]

app = Flask(__name__)
metrics = PrometheusMetrics(app)



from logging.config import dictConfig

dictConfig({
    'version': 1,
    'formatters': {'default': {
        'format': '[%(asctime)s] %(levelname)s in %(module)s: %(message)s',
    }},
    'handlers': {'wsgi': {
        'class': 'logging.StreamHandler',
        'formatter': 'default'
    }},
    'root': {
        'level': 'DEBUG',
        'handlers': ['wsgi']
    }
})



@app.route('/getRandomData',methods=['GET'])
def getRandomData():
    logging.info('GET /getRandomData')
    try:
        with open('data.json') as f:
            data = json.load(f)
        return { "Mood" : random.choice(data["mood"]) }
    except:
        logging.error('GET /getRandomData failed with exception !!')
        return { "Mood" : "NoData" } , 500


@app.route('/')
def main():
    return 'CreativeAdvancedTechnology Assignment Working ok !!'


if __name__ == "__main__":
    app.app.run(debug=True, host='0.0.0.0', port=config["default"]["Port"])
