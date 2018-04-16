FROM centos:7

LABEL maintainer="D.R4F4EL <d.r4f4el@gmail.com>"
LABEL version="MongoDB 3.6, CentOS 7"

ARG HOST_UID
ARG HOST_GID

ENV MONGO_UID ${HOST_UID:-1000}
ENV MONGO_GID ${HOST_GID:-1000}

RUN set -ex; \
  groupadd mongodb --gid $MONGO_GID; \
  useradd mongodb --uid $MONGO_UID --gid $MONGO_GID --shell /sbin/nologin --no-create-home

COPY mongodb-org-3.6.repo /etc/yum.repos.d/

RUN set -ex; yum -y update; \
  yum install -y mongodb-org; \
  yum clean all; \
  mkdir -p /data/db /data/configdb; \
  chown -R $MONGO_UID:$MONGO_GID /data/db /data/configdb; \
  mv /etc/mongod.conf /etc/mongod.conf.orig

ENV GOSU_VERSION 1.10

RUN set -ex; \
	\
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
	yum -y remove wget dpkg; \
	yum clean all

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

VOLUME /data/db /data/configdb

EXPOSE 27017
CMD ["mongod"]
