# Python

Pre installed packages:

* CentOS 7 base image
* Python 3.6.6
* pip 18

#### How to Build

```
docker build -f Dockerfile . -t python:latest
```

#### How to Run

```
docker run -it --rm python:latest
```

#### RTFM

* [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
