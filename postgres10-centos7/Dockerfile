FROM centos:7

LABEL maintainer="D.R4F4EL <d.r4f4el@gmail.com>"
LABEL version="PostgreSQL 10, CentOS 7"

ARG HOST_UID
ARG HOST_GID

ENV PG_UID="${HOST_UID:-1000}" \
    PG_GID="${HOST_GID:-1000}" \
    PG_URL="https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-ppc64le/pgdg-centos10-10-2.noarch.rpm" \
    PG_MAJOR=10

RUN set -ex; \
  groupadd postgres --gid $PG_GID; \
  useradd postgres --uid $PG_UID --gid $PG_GID --home-dir /var/lib/pgsql --shell /sbin/nologin --no-create-home

RUN set -ex; yum -y update; \
  \
# install
  yum install -y $PG_URL; \
  yum install -y postgresql${PG_MAJOR}-server; \
# cleanup
  yum clean all

ENV PG_DIR /usr/pgsql-$PG_MAJOR
ENV PATH $PG_DIR/bin:$PATH

# make the sample config correct by default
RUN set -ex; \
  sed -ri "s!^#?(listen_addresses)\s*=\s*\S+.*!\1 = '*'!" $PG_DIR/share/postgresql.conf.sample; \
  sed -ri "s!^(logging_collector)\s*=\s*\S+.*!\1 = off!" $PG_DIR/share/postgresql.conf.sample

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

COPY docker-entrypoint.sh /usr/local/bin/

RUN set -ex; \
# backwards compat
  ln -s /usr/local/bin/docker-entrypoint.sh / ; \
  chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

ENV PGDATA /var/lib/pgsql/$PG_MAJOR/data/

VOLUME /tmp
VOLUME /var/run/postgresql
VOLUME $PGDATA

EXPOSE 5432

CMD ["postgres"]
