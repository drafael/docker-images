# MongoDB

Pre installed packages:

* CentOS 7 base image
* MongoDB v3.6
* [gosu](https://github.com/tianon/gosu#gosu) for easy step-down from root

#### How to Build

```
docker build -f Dockerfile . -t mongodb
```

or, using [Docker compose](https://docs.docker.com/compose/overview/)

```
docker-compose build
```


#### How to Run

```
docker run -d -p 27017:27017 --volume=$(pwd)/db:/data/db mongodb
```

or, using [Docker compose](https://docs.docker.com/compose/overview/)

```
docker-compose up -d
```

#### RTFM

* [Compose file reference](https://docs.docker.com/compose/compose-file/)
* [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)


# License

Most MongoDB source files are made available under the terms of the GNU Affero General Public License (AGPL).  
See individual files for details.

As an exception, the Docker-related files are made available under the terms of the Apache License, version 2.0.