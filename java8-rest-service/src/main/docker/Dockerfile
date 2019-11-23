FROM openjdk:8-jre-alpine

LABEL maintainer="D.R4F4EL <d.r4f4el@gmail.com>" \
      component="@project.artifactId@" \
      version="@project.version@"

ARG HOST_UID=1000
ARG HOST_GID=1000
ARG USER_NAME=app
ARG JAR_FILE

ENV APP_DIR=/${USER_NAME} \
    APP_UID=${HOST_UID} \
    APP_GID=${HOST_GID} \
    SPRING_PROFILES_ACTIVE="docker" \
    SERVER_PORT=8080 \
    JAR_FILE=${JAR_FILE:-@project.build.finalName@.jar} \
    JAVA_OPTS="-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -Djava.security.egd=file:/dev/urandom ${JAVA_OPTS}"

RUN set -ex; \
    mkdir -p ${APP_DIR} && \
    # install JavaMelody monitoring dependencies
    apk add --no-cache fontconfig ttf-dejavu && \
    # grab su-exec for easy step-down from root
    apk add --no-cache 'su-exec>=0.2' && \
    # add user and group
    addgroup ${USER_NAME} -g ${APP_GID} -S && \
    adduser ${USER_NAME} -u ${APP_UID} -G ${USER_NAME} -g ${USER_NAME} -H -h ${APP_DIR} -s /sbin/nologin -S

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

VOLUME /tmp

EXPOSE ${SERVER_PORT}

CMD java ${JAVA_OPTS} -jar ${JAR_FILE}
