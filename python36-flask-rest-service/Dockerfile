FROM python:3.6-slim

ARG HOST_UID=1000
ARG HOST_GID=1000
ARG APP_DIR=/app

ENV APP_UID=${HOST_UID} \
    APP_GID=${HOST_GID} \
    APP_DIR=${APP_DIR:-/app} \
    USER_NAME=service \
    FLASK_APP="app.py" \
    GUNICORN_PORT=5000 \
    GUNICORN_WORKERS=1 \
    GUNICORN_WORKER_TIMEOUT=120

WORKDIR ${APP_DIR}

COPY requirements.txt ${APP_DIR}/
COPY docker-entrypoint.sh /usr/bin

RUN set -ex; \
    apt-get update && \
    apt-get install -y gosu && \
    apt-get autoclean && \
    apt-get autoremove && \
    pip3 install --upgrade pip --no-cache-dir && \
    pip3 install -r requirements.txt --no-cache-dir && \
    groupadd ${USER_NAME} --gid ${APP_GID} && \
    useradd ${USER_NAME} --uid ${APP_UID} --gid ${APP_GID} --shell /sbin/nologin --home-dir ${APP_DIR} --no-create-home && \
    chown -R ${APP_UID}:${APP_GID} ${APP_DIR} && \
    chmod +x /usr/bin/docker-entrypoint.sh

COPY --chown="service:service" . ${APP_DIR}/

USER ${USER_NAME}

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE ${GUNICORN_PORT}

# see https://sebest.github.io/post/protips-using-gunicorn-inside-a-docker-image/
# CMD ["python3", "-m", "flask", "run", "--host=0.0.0.0"]
CMD ["gunicorn", "--config", "gunicorn.py", "app:app"]
