# Python

Pre installed packages:

* CentOS 7 base image
* Python 3, pip, venv dir `/app`
* [gosu](https://github.com/tianon/gosu#gosu) for easy step-down from root

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
