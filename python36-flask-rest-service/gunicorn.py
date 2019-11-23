import os
import multiprocessing


host = os.environ.get('GUNICORN_HOST', default='0.0.0.0')
port = os.environ.get('GUNICORN_PORT', default=5000)

# http://docs.gunicorn.org/en/stable/settings.html#bind
bind = '{0}:{1}'.format(host, port)

# http://docs.gunicorn.org/en/stable/settings.html#loglevel
loglevel = os.environ.get('GUNICORN_LOG_LEVEL', default='info')

# http://docs.gunicorn.org/en/stable/settings.html#worker-class
workers = int(os.environ.get('GUNICORN_WORKERS', default=multiprocessing.cpu_count() * 2 + 1))

# http://docs.gunicorn.org/en/stable/settings.html#worker-class
#worker_class = 'gevent'

# http://docs.gunicorn.org/en/stable/settings.html#timeout
timeout = int(os.environ.get('GUNICORN_WORKER_TIMEOUT', default=120))
