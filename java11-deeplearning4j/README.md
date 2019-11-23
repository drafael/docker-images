# How to Use Deeplearning4j with Docker

### Requirements
* Java 11 (OpenJDK)
* Maven
* Familiarity with [Spring Boot](https://projects.spring.io/spring-boot/)    
* Familiarity with [Docker](https://docs.docker.com/engine/docker-overview/)
* Familiarity with [Deeplearning4j](https://deeplearning4j.org/)    

### How to Build
```
mvn package
```

### How to Build Docker image
```
mvn package -P docker
```  

#### How to Run 
```
mvn spring-boot:run
```

### See Also
* <https://deeplearning4j.org/docs/latest/>
* <https://deeplearning4j.org/api/latest/>
* [Deeplearning4J Examples](https://github.com/deeplearning4j/dl4j-examples)
* [Dockerfile Maven Plugin](https://github.com/spotify/dockerfile-maven#dockerfile-maven)