FROM centos:7

LABEL maintainer="D.R4F4EL <d.r4f4el@gmail.com>"
LABEL version="Python 3, CentOS 7"

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG en_US.utf8
ENV LC_ALL en_US.utf8

ENV PYTHON_VERSION 3.6.6

RUN set -ex; yum -y update; \
  \
# install prerequisites
  yum groupinstall -y "Development Tools"; \
  \
  yum install -y wget zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel libffi-devel expat-devel; \
  wget -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz"; \
  wget -O python.tar.xz.asc "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc"; \
  \
# verify the signature
  export GNUPGHOME="$(mktemp -d)"; \
  gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 0D96DF4D4110E5C43FBFB17F2D347EA6AA65421D; \
  gpg --batch --verify python.tar.xz.asc python.tar.xz; \
  { command -v gpgconf > /dev/null && gpgconf --kill all || :; }; \
  rm -rf "$GNUPGHOME" python.tar.xz.asc; \
  \
  mkdir -p /usr/src/python; \
  tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz; \
  rm python.tar.xz; \
  \
  cd /usr/src/python; \
  ./configure \
        --prefix=/usr/local \
        --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib" \
  		--enable-loadable-sqlite-extensions \
  		--with-system-expat \
  		--with-system-ffi \
  		--without-ensurepip \
  ; \
  make && make install && ldconfig; \
  \
# verify that the binaries work
  python3 --version; \
  \
  find /usr/local -depth \
  		\( \
  			\( -type d -a \( -name test -o -name tests \) \) \
  			-o \
  			\( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
  		\) -exec rm -rf '{}' +; \
  rm -rf /usr/src/python; cd /; \
  \
  yum remove -y wget; \
  yum clean all

ENV PYTHON_PIP_VERSION 18.0

RUN set -ex; \
    yum install -y wget; \
	\
	wget -O get-pip.py 'https://bootstrap.pypa.io/get-pip.py'; \
	\
	python3 get-pip.py --disable-pip-version-check --no-cache-dir "pip==$PYTHON_PIP_VERSION"; \
	\
# verify that the pip works	
	/usr/local/bin/pip --version; \
	\
	find /usr/local -depth \
		\( \
			\( -type d -a \( -name test -o -name tests \) \) \
			-o \
			\( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
		\) -exec rm -rf '{}' +; \
	rm -f get-pip.py; \
	\
    yum remove -y wget; \
    yum clean all

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
    yum remove -y wget dpkg; \
    yum clean all


COPY docker-entrypoint.sh /usr/local/bin
RUN set -ex; \
  chmod +x /usr/local/bin/docker-entrypoint.sh

ARG HOST_UID
ARG HOST_GID
ARG VENV_DIR

ENV VENV_UID ${HOST_UID:-1000}
ENV VENV_GID ${HOST_GID:-1000}
ENV VENV_DIR ${VENV_DIR:-/app}

RUN set -ex; \
  groupadd python --gid $VENV_GID; \
  useradd python --uid $VENV_UID --gid $VENV_GID --shell /sbin/nologin --home-dir $VENV_DIR --no-create-home; \
  \
  python3 -m venv $VENV_DIR; \
  chown -R $VENV_UID:$VENV_GID $VENV_DIR

WORKDIR $VENV_DIR

USER python

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["python3"]
