+++
title = 'Make Use of SOLID Coding Principles'
date = 2019-08-04T22:04:27+02:00
draft = false
tags = ['solid', 'tech', 'design pattern']
+++
We all know what are the pros and cons of Object Oriented Programming, but what about writing better codes? What about making it more flexible and easier to read? Well, here are some tips on SOLID Design Pattern and the easy thumb rules to keep in mind while coding.

I am personally focused on how to use SOLID principles with some practical approaches, rather than understanding the huge theoretical knowledge. So, below I have tried to explain the approaches as simplified as possible. I am a strong believer of starting with something and then improvising on my own.

# Single Responsibility Principle

 ***A class should have a single responsibility and one reason to change.***

## What should be done ?

Always think of the logic and the business rules which are only **applicable** for that class.

“Gather together the things that change for the same reasons. Separate those things that change for different reasons.”- Robert C. Martin

![](https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExem1xcmNzYWc3MzdleW55OWhudzR4amQ5NHlycGR0M2QzcGpwam1pbSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/U6pm4rLysiWCaLQ5CP/giphy.gif)

# Open-Close Principle

***A class should be open for extension and closed for modification.***

### What we need to do ?

Write your codes in a way so that, if someone wants to add a new functionality to the class in future, he or she won’t have to touch your existing code.

![](https://media1.tenor.com/m/9SjKJ_ll6vUAAAAC/christmas-vacation-raw.gif)

# Liskov Substitution Principles

***Any object of some class in can be replaced by an object of a child class.***

### What needs to be done ?

If you have two classes, class A and class B, where B is a subclass of A, all the methods which are mentioned in class A should have implementation in class B.

![](https://media.giphy.com/media/kwEmwFUWO5Ety/giphy.gif)

# Interface Segregation Principle

***Clients should not be forced to depend on methods that they do not use.***

### What is it all about ?

Lets’ assume, I have an interface having two methods x() and y(). Two of my classes A and B implements the interface, but Class A has only the functionality of x(), where Class B has both of the functionalities x() and y(). The easiest way to solve this is, override y() in class A, and implement nothing in it… which will directly lead us to the situation shown in the gif above.

The **Pattern** is to create two interfaces. One will have the common functionalities and the second interface will have the extra functions (i.e. y() from the above example) and will extend the first interface. Now, when we will implement class A, we will implement the first interface, but for class B, we will implement the second interface.

![](https://media1.tenor.com/m/PzVRV2ECyUEAAAAd/upset-sold-out.gif)

# Data Inversion Principle

***High level modules should not depend upon low level modules. Both should depend upon abstractions.***

### What does this mean ?

We should not extend concrete classes, we should always depend on abstractions like abstract classes or interfaces.

![](https://media1.tenor.com/m/fZaDZ1FJCnIAAAAd/bo-burnham-inside.gif)
