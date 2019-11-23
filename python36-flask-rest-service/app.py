import logging

from flask import Flask, jsonify
from healthcheck import HealthCheck

app = Flask(__name__)

# wrap the flask app and give a /health url
health = HealthCheck(app, "/health")


# health check function
def custom_health_check():
    return True, "Custom health check is OK"

health.add_check(custom_health_check)


# simple REST endpoint
@app.route('/hello', methods=['GET'])
def say_hello():
    result = {'message': 'Hello World!'}
    return jsonify(result)


# entry point
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
else:
    gunicorn_logger = logging.getLogger('gunicorn.error')
    app.logger.handlers = gunicorn_logger.handlers
    app.logger.setLevel(gunicorn_logger.level)
