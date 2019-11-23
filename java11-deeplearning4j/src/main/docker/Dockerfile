FROM openjdk:11-jre-slim

LABEL maintainer="D.R4F4EL <d.r4f4el@gmail.com>" \
      component="@project.artifactId@" \
      version="@project.version@"

ARG HOST_UID=1000
ARG HOST_GID=1000
ARG USER_NAME=app
ARG JAR_FILE

ENV APP_DIR=/${USER_NAME}
# https://stackoverflow.com/questions/44598965/physical-memory-usage-is-too-high
ENV ND4J_OPTS="-Dorg.bytedeco.javacpp.cachedir=${APP_DIR}/cache -Dorg.bytedeco.javacpp.maxphysicalbytes=0 -Dorg.bytedeco.javacpp.maxbyte=0"

ENV \
  APP_UID=${HOST_UID} \
  APP_GID=${HOST_GID} \
  SPRING_PROFILES_ACTIVE="docker" \
  SERVER_PORT=8080 \
  JAR_FILE=${JAR_FILE:-@project.build.finalName@.jar} \
  JAVA_OPTS="-Djava.awt.headless=true -Djava.security.egd=file:/dev/urandom ${JAVA_OPTS} ${ND4J_OPTS}"

RUN set -ex; \
    apt-get update && \
    apt-get install -y gosu && \
    apt-get autoclean && apt-get autoremove -y && \
    mkdir -p ${APP_DIR}/cache && \
    groupadd ${USER_NAME} --gid ${APP_GID} && \
    useradd ${USER_NAME} --uid ${APP_UID} --gid ${APP_GID} --shell /sbin/nologin --home-dir ${APP_DIR} --no-create-home && \
    chown -R ${APP_UID}:${APP_GID} ${APP_DIR}

COPY ${JAR_FILE} ${APP_DIR}
COPY docker-entrypoint.sh /usr/bin

RUN set -ex; \
  find ${APP_DIR} -type d -exec chmod 755 {} \; && \
  find ${APP_DIR} -type f -exec chmod 644 {} \; && \
  chown -R ${APP_UID}:${APP_GID} ${APP_DIR}    && \
  chmod +x /usr/bin/docker-entrypoint.sh

WORKDIR ${APP_DIR}

USER ${USER_NAME}

ENTRYPOINT ["docker-entrypoint.sh"]

VOLUME /tmp ${APP_DIR}/cache

EXPOSE ${SERVER_PORT}

CMD java ${JAVA_OPTS} -jar ${JAR_FILE}
