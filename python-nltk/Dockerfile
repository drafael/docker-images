FROM python:3.6-slim

ENV APP_DIR=/app
ENV NLTK_DATA=${APP_DIR}/data/nltk

COPY download-data.py ${APP_DIR}/

WORKDIR ${APP_DIR}

RUN set -ex; \
    pip3 install --upgrade pip --no-cache-dir && \
    pip3 install nltk --no-cache-dir && \
    mkdir -p ${NLTK_DATA} && \
    python3 "${APP_DIR}/download-data.py" && \
    rm -rf /var/lib/apt/lists ${NLTK_DATA}/corpora/*.zip
