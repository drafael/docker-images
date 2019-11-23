# Apache Tomcat

Pre installed packages:

* CentOS 7 base image
* Java 8 (JRE)
* [gosu](https://github.com/tianon/gosu#gosu) for easy step-down from root
* Apache Tomcat v8.5.29
  - CATALINA_HOME=/usr/local/tomcat 

#### How to Build

```
docker build -f Dockerfile . -t tomcat
```

or, using [Docker compose](https://docs.docker.com/compose/overview/)

```
docker-compose build
```


#### How to Run

```
docker run -d -p 8080:8080 --rm \
  --tmpfs /usr/local/tomcat/logs:rw,exec \
  --tmpfs /usr/local/tomcat/temp:rw,exec \
  --tmpfs /usr/local/tomcat/work:rw,exec \
  --tmpfs /usr/local/tomcat/conf/Catalina:rw,exec \
  tomcat
```

or, using [Docker compose](https://docs.docker.com/compose/overview/)

```
docker-compose up -d
```

#### RTFM

* [Compose file reference](https://docs.docker.com/compose/compose-file/)
* [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
