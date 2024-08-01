+++
title = 'Sidecar Design Pattern: Advantages & Disadvantages'
date = 2020-05-13T23:45:25+02:00
draft = false
tags = ['sidecar','design pattern', 'microservices', 'infrastructure', 'tech']
+++
The sidecar design pattern is being adopted by a large number of companies and tech communities now a days. It is opening a new horizon in the world of distributed systems. The service mesh architecture also played a big role in this design pattern. It is obvious that this pattern has advantages and disadvantages. But above all, it is always very interesting to know, why a new design pattern is introduced and what was the problem in the old one ?

![](https://drive.google.com/thumbnail?id=1OFl5aVrhmjXV7mqLGZFOIJvYoAfGdSdw&sz=w500)

The term *"sidecar"* in technology comes from motorcycles, where a sidecar is an extra seat attached to the side of the bike. In tech, "sidecar" describes an extra component that works alongside a main system to add or enhance features without changing the main system itself.

The picture above was generated using AI.

## The Service Mesh - the concept behind the sidecar technology

A service mesh is a dedicated infrastructure layer that manages service-to-service communication within a microservices architecture. It is designed to handle a variety of operational concerns like traffic management, security, and observability, which are essential for microservices but can be complex to implement and maintain.

### Drawbacks of the old Microservice Architecture

The technology world changed when the *cool, good looking* microservices took over the monolith architecture but the boon came with a price tag.

The services became heavily dependent on the network. The number of services increased with a burden of dealing with the interactions, logging and monitoring functionalities between them. Each of the services started having some messy infrastructural code to make sure the application has a multiple points of failure. And all of these burdens were directly proportional to the number of microservices in the system.

### When Service Mesh came into the scene

Different companies came up with their own implementation of handling these infrastructural problems. For an example, Netflix came up with their own libraries like Eureka, Hystrix and Ribbon, which helped us to overcome the common functionality problems, but these libraries required a lot of configuration to work properly.

At this point of time, **Service Mesh** made the developers’ life easier than before. Typically, the Service Mesh Architecture is like running a service proxy that decouples and handles all the common functionalities like authentication, service discovery, traffic management etc. from the microservices and runs as a single service.

So, why not making it a bit more cool ?

## The Sidecar Pattern

The pattern of creating a service proxy and segregating the common functionalities from the microservices into that proxy is known as the “Sidecar Pattern.” It enables the developers to add a number of functionalities to the application without any third-party library and their arguably messy configurations.

Take a look at [Envoy](https://www.envoyproxy.io/), developed by [Lyft](https://en.wikipedia.org/wiki/Lyft).

The sidecar pattern consists of two containers which run alongside each other. The first one is the Application Container, which holds the core business logic of the service and the second one is the Sidecar Container which enables all the other infrastructural functionalities to the attached application container.

### How does the sidecar work ?

Simply, each of the microservices holds the same copy of sidecar which runs alongside them.

As a result, the microservices do not know about the network or the infrastructure, it only knows about the sidecar container attached to it. And on the other side, the sidecar proxy takes full control of all the infrastructural functionalities like managing the incoming and the outgoing traffic between the microservices, gathering metrics etc. In other words, it makes the attached microservice network independent.

#### Who controls the sidecars then ?

Beside the microservices and the sidecar containers, there is a Service Mesh Layer which controls the traffic flow towards the sidecars. E.g. Istio

There are typically two functions of this layer :

- Handling the functionalities like service discovery, traffic management etc. inside the service mesh, aka Data Plane’s Responsibility.
- Manage the sidecars and collecting metrics, aka Control Plane’s Responsibility.

![](https://drive.google.com/thumbnail?id=16aN8ssRLntQtS239cRR7e2FuhOCgsbOd&sz=w500)

#### Advantages of Sidecar Pattern

- Makes developers' life easy by reducing the code duplication of writing same configurations.
- Decreases complexities by abstracting the infrastructural codes into a different layer.
- Makes the microservice independent of the underlying network layer.

#### Disadvantages of Sidecar Pattern

- Lots of communications. To gain some benefits, by using the sidecar pattern, the service mesh should be introduced in the system and it creates a whole lot of pain in terms of inter-process communications.
- The sidecar pattern will not work without the containerised environment.
- Above all, There are some disadvantage too in terms of size of the application. Due a huge number of sidecars, the memory utilisation also increases.
