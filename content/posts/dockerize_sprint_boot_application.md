+++
title = 'Dockerize a Spring Boot Applications'
date = 2019-06-07T21:49:45+02:00
draft = false
tags = ['docker', 'spring boot', 'maven', 'spotify docker plugin', 'java']
+++
In this article, I am going to discuss an interesting part of the newly created application, i.e. how to dockerize spring boot applications. Before jumping into the solution, let’s have a brief idea – why we should dockerize an application ?

## Why Docker ?

Well, There is huge list of pros. (also cons.), but for me the advantage is, any Operating System which can run docker, will be able to run my application.

## The Requirements

1. A Spring Boot 2 Application to make a docker image of it.
2. A docker registry where you one store the docker images and maintain those by providing proper tags. Here anyone can create one free at [Canister](https://cloud.canister.io/).

## The Dependency

Now, it is time to add the dependency to the pom.xml file. Well, there are multiple plugins to create docker from maven projects but I liked the one created by Spotify. I found it easy to configure and run. So, here it is – Just need to use the below code snippet in the <build> part and replace with the docker registry username, password and repository url for dockers.

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

We're almost done. Just one step left which is to create the docker file.

## The Dockerfile

This docker file will be used by the dockerfile-maven-plugin during the build phase. We need to create a file named “Dockerfile” at the same level of the pom.xml. The content of this file should look like below :

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

![](https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExdDJ2dmRzZnVieTgzMnU3M2JiZXg5eWxsNXRjdm9qbm1nOWlieHhuYiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/lTpme2Po0hkqI/giphy.webp)
