FROM centos:7

LABEL maintainer="D.R4F4EL <d.r4f4el@gmail.com>"
LABEL version="Solr 6.4.2, CentOS 7"

ARG HOST_UID
ARG HOST_GID
ARG SOLR_CORE

ENV SOLR_UID="${HOST_UID:-1000}" \
    SOLR_GID="${HOST_GID:-1000}" \
    SOLR_CORE=${SOLR_CORE:-default} \
    SOLR_HOME="/opt/solr/server/solr" \
    LOG4J_PROPS="/opt/solr/server/solr/log4j.properties" \
    GC_LOG_OPTS="" \
    SOLR_VERSION="6.4.2" \
    SOLR_URL="https://archive.apache.org/dist/lucene/solr/6.4.2/solr-6.4.2.tgz" \
    SOLR_SHA256="354e1affd9cad7d6e86cde8c03aaeb604876f0764129621d8e231cdb35b31c55" \
    SOLR_KEYS="2085660D9C1FCCACC4A479A3BF160FF14992A24C" \
    PATH="/opt/solr/bin:/opt/docker-solr/scripts:$PATH" \
#    SOLR_LOG_LEVEL="INFO"
    SOLR_LOG_LEVEL="WARN"
#    SOLR_LOG_LEVEL="OFF"

RUN set -ex; \
  groupadd --gid $SOLR_GID solr; \
  useradd --uid $SOLR_UID --gid $SOLR_GID --home-dir /opt/solr --shell /sbin/nologin --no-create-home solr

ENV JAVA_VERSION 1.8.0-openjdk

RUN set -ex; yum -y update; \
  \
# install java
  yum -y install java-$JAVA_VERSION; \
  \
# prerequisites
  yum -y install lsof wget; \
  \
  export GNUPGHOME="$(mktemp -d)"; \
  \
  for key in $SOLR_KEYS; do \
    found=''; \
    for server in ha.pool.sks-keyservers.net hkp://keyserver.ubuntu.com:80 hkp://p80.pool.sks-keyservers.net:80 pgp.mit.edu; \
    do \
      echo "  trying $server for $key"; \
      gpg --keyserver "$server" --keyserver-options timeout=10 --recv-keys "$key" && found=yes && break; \
    done; \
    test -z "$found" && echo >&2 "error: failed to fetch $key from several disparate servers -- network issues?" && exit 1; \
  done; \
  \
# install Solr
  mkdir -p /opt/solr; \
  wget -nv $SOLR_URL -O /opt/solr.tgz; \
  wget -nv $SOLR_URL.asc -O /opt/solr.tgz.asc && \
  echo "$SOLR_SHA256 */opt/solr.tgz" | sha256sum -c - && \
  (>&2 ls -l /opt/solr.tgz /opt/solr.tgz.asc); \
  gpg --batch --verify /opt/solr.tgz.asc /opt/solr.tgz; \
  tar -C /opt/solr --extract --file /opt/solr.tgz --strip-components=1 && \
  rm /opt/solr.tgz*; \
  rm -Rf /opt/solr/docs/; \
  mkdir -p /opt/solr/server/solr/lib /opt/solr/server/solr/default /opt/solr/server/logs /docker-entrypoint-initdb.d /opt/docker-solr; \
  sed -i -e 's/"\$(whoami)" == "root"/$(id -u) == 0/' /opt/solr/bin/solr; \
  sed -i -e 's/lsof -PniTCP:/lsof -t -PniTCP:/' /opt/solr/bin/solr; \
  sed -i -e '/-Dsolr.clustering.enabled=true/ a SOLR_OPTS="$SOLR_OPTS -Dsun.net.inetaddr.ttl=60 -Dsun.net.inetaddr.negative.ttl=60"' /opt/solr/bin/solr.in.sh; \
  chown -R $SOLR_UID:$SOLR_GID /opt/solr; \
  \
# cleanup
  yum -y remove wget; \
  yum clean all

# Docker scripts
COPY scripts /opt/docker-solr/scripts/
RUN set -ex; \
  chown -R $SOLR_UID:$SOLR_GID /opt/docker-solr /opt/solr; \
  chmod +x /opt/docker-solr/scripts/*

# gosu for easy step-down from root
ENV GOSU_VERSION 1.10
RUN set -ex; \
  \
# grab gosu for easy step-down from root
  yum -y install epel-release; \
  yum -y install wget dpkg; \
  \
  dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
  wget -O /usr/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
  wget -O /tmp/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
  \
# verify the signature
  export GNUPGHOME="$(mktemp -d)"; \
  gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
  gpg --batch --verify /tmp/gosu.asc /usr/bin/gosu; \
  rm -r "$GNUPGHOME" /tmp/gosu.asc; \
  \
  chmod +x /usr/bin/gosu; \
# verify that the binary works
  gosu nobody true; \
  \
# cleanup
  yum -y remove wget dpkg; \
  yum clean all

VOLUME $SOLR_HOME/${SOLR_CORE:-default}
VOLUME /opt/solr/server/logs

WORKDIR /opt/solr

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 8983

CMD ["solr-foreground"]
