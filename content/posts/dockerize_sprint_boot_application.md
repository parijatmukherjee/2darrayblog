+++
title = 'How to Dockerize Spring Boot Applications'
date = 2019-06-07T21:49:45+02:00
draft = false
+++
In this article, I am going to discuss an interesting part of the newly created application, i.e. how to dockerize spring boot applications. Before jumping into the solution, let’s have a brief idea – why we should dockerize an application ?

## Why Docker ?

Well, There is huge list of pros. (also cons.), but for me the advantage is, any Operating System which can run docker, will be able to run your application. If you are new to Docker, I will suggest you to have quick read of this article here.

## The Requirements

### Spring Boot 2 Application

I believe you have a Spring Boot 2 Application with you to make a docker image of it.

### Docker Registry

You must have a docker registry where you can store your docker images and maintain those by providing proper tags.

If you don’t have any docker registry, you can create free at [Canister](https://cloud.canister.io/). Just go ahead and create an account.

## The Dependency

Now, it is time to add the dependency to your pom.xml file. Well, there are multiple plugins to create docker from maven projects but I liked the one created by Spotify. I found it easy to configure and run. So, here it is – Just use the below code snippet in your <build> part and replace with your docker registry username, password and repository url for dockers.

```xml
<build>
    <plugins>
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
        </plugin>
        <plugin>
            <groupId>com.spotify</groupId>
            <artifactId>dockerfile-maven-plugin</artifactId>
            <version>${dockerfile-maven-version}</version>
            <executions>
                <execution>
                    <id>default</id>
                    <goals>
                        <goal>build</goal>
                        <goal>push</goal>
                    </goals>
                </execution>
            </executions>
            <configuration>
                <username>############</username>
                <password>############</password>
                <repository>################</repository>
                <tag>${project.version}</tag>
                <buildArgs>
                    <JAR_FILE>${project.build.finalName}.jar</JAR_FILE>
                </buildArgs>
            </configuration>
        </plugin>
    </plugins>
</build>
```

You’re almost done. Just one step left which is to create the docker file.

## The Dockerfile

This docker file will be used by the dockerfile-maven-plugin during the build phase. You need to create a file named “Dockerfile” at the same level of your pom.xml. The content of this file should look like below :

```java
FROM openjdk:8-jre
ARG JAR_FILE
ADD target/${JAR_FILE} /opt/<YOUR_PROJECT_NAME>/<YOUR_ARTIFACT_NAME>.jar
ENTRYPOINT ["java", "-jar", "/opt/<YOUR_PROJECT_NAME>/<YOUR_ARTIFACT_NAME>.jar"]
```

### Steps During the Docker Build Phase

- The plugin will use OpenJDK 8 JRE as the base of your container.
- The ARG JAR_FILE will extract the project name from the pom.xml because in the plugin configuration you have mentioned it.
- Now, it will put the jar from the target folder to its destination of your container. (Don’t miss the <space> between “target/${JAR_FILE}” and “/opt/<YOUR_PROJECT_NAME>/<YOUR_ARTIFACT_NAME>.jar”)
- It creates an ENTRYPOINT which means, when this docker will start running, it will execute the java -jar command.
- Finally when the docker build is completed, it will push the image to your remote docker registry.

I hope you have successfully pushed your docker image to your docker registry and you liked my post on how to dockerize spring boot applications.
