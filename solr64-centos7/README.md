# Apache Solr

Pre installed packages:

* Java 8 (JRE)
* [gosu](https://github.com/tianon/gosu#gosu) for easy step-down from root
* Apache Solr v6.4.2

#### How to Build

```
docker build -f Dockerfile . -t solr
```

or, using [Docker compose](https://docs.docker.com/compose/overview/)

```
docker-compose build
```

#### How to Run

```
SOLR_CORE=mycore

docker run -p 8983:8983 --rm \
  --env SOLR_PID_DIR=/var/solr \
  --tmpfs /var/solr  \
  --tmpfs /opt/solr/server/logs \
  --volume=$(pwd)/$SOLR_CORE:/opt/solr/server/solr/$SOLR_CORE \
  solr:latest
```

or, using [Docker compose](https://docs.docker.com/compose/overview/)

```
docker-compose up
```

#### RTFM

* [Compose file reference](https://docs.docker.com/compose/compose-file/)
* [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
