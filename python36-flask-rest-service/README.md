# Python Microservice

Sample Microservice in Python

#### Requirements:

* [Install Docker Community Edition (CE)](https://docs.docker.com/install/)
  - [Install Docker for Windows](https://docs.docker.com/docker-for-windows/install/)
  - [Install Docker for Mac](https://docs.docker.com/docker-for-mac/install/)

#### How to Build

```
docker build -t python-service:latest .
```
See also <https://docs.docker.com/engine/reference/commandline/build/>


#### How to Run

```
docker run -it --rm -p 5000:5000 python-service:latest
```
Press `Ctrl + C` to stop the service. See also <https://docs.docker.com/engine/reference/run/>

#### How to Check

Health check:

```bash
curl http://localhost:5000/health
```

Simple REST service:

```bash
curl http://localhost:5000/hello
```


#### Documentation

* [Flask’s documentation](http://flask.pocoo.org/docs/1.0/)
  - <https://github.com/Runscope/healthcheck>
* [Docker Documentation](https://docs.docker.com/)
  - [Docker development best practices](https://docs.docker.com/develop/dev-best-practices/)
* [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
  - [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
* [12-factor App](https://12factor.net/)