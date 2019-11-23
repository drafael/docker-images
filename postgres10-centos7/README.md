# PostgreSQL

Pre installed packages:

* [gosu](https://github.com/tianon/gosu#gosu) for easy step-down from root
* PostgreSQL 10

#### How to Build

```
docker build -f Dockerfile . -t pgsql-centos
```

or, using [Docker compose](https://docs.docker.com/compose/overview/)

```
docker-compose build
```

#### How to Run

```
docker run -d --rm -p 5432:5432 \
  --env POSTGRES_PASSWORD=secret \
  --volume=$(pwd)/data:/var/lib/pgsql/10/data \
  --tmpfs /var/run/postgresql \
  --tmpfs /tmp  \
  pgsql-centos
```

or, using [Docker compose](https://docs.docker.com/compose/overview/)

```
docker-compose up -d
```

#### RTFM

* [Compose file reference](https://docs.docker.com/compose/compose-file/)
* [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
