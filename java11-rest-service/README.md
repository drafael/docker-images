### Requirements
* Java 11 (OpenJDK)
* Maven
* Familiarity with [Spring Boot](https://projects.spring.io/spring-boot/)    
* Familiarity with [Docker](https://docs.docker.com/engine/docker-overview/)    

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

##### Test Endpoint 
```
curl http:localhost:8080/api/hello
```

##### [JavaMelody](https://github.com/javamelody/javamelody/wiki) monitoring endpoint
* `/monitoring`

### See Also
* [Dockerfile Maven Plugin](https://github.com/spotify/dockerfile-maven#dockerfile-maven)