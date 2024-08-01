+++
title = 'Create MariaDB Galera Cluster in CentOS 6.x'
date = 2017-10-14T20:11:37+02:00
draft = false
+++

In this post, I'm sharing my experience setting up a MariaDB Galera cluster with three nodes on CentOS 6.x. I'll walk everyone through the setup and configurations I used, and by the end, everyone should be able to apply these steps to other CentOS or RHEL distributions. Let's dive into it!

## Overview of Galera Cluster MariaDB

Galera cluster is a multi-master database setup which replicates the data synchronously among the nodes. Generally, we use MySQL or MariaDB server to create a Galera Cluster which uses Galera Replication plugin to replicate the data. It is always recommended to keep the “quorum mechanism” while setting up the galera cluster nodes. For more information on the “Quorum Mechanism”, have a look in the [Galera Cluster Weighted Quorum Documentation](<https://galeracluster.com/library/documentation/weighted-quorum.html>).

## Galera Cluster Setup in CentOS 6

The first step is to setup the MariaDB server in all the nodes of the cluster. Here’s how to install MariaDB server in centOS 6.x.

Setup Yum Repo at /etc/yum.repos.d/MariaDB.repo

```shell
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/5.5/centos6-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
```

To install MariaDB using Yum, run the commands below :

```shell
yum clean all
yum install MariaDB-Galera-server MariaDB-client galera
service mysql start
mysql_secure_installation
```

Run the command to check whether the MariaDB server is running successfully or not.

```shell
mysql -uroot -p<YOUR PASSWORD (IF ANY)>
```

Once you succeed in installing MariaDB, stop the service for now by using the command :

```shell
service mysql stop
```

## Galera Cluster Configuration

Go to /etc/my.cnf and check for the following configurations. Here I am considering that you are going to involve three nodes in the galera cluster… and the IP addresses are 101.10.101.10, 111.11.111.11, 121.12.121.12.

I am providing a snapshot of the specific properties in my /etc/my.cnf configured for Galera Cluster :

```shell
....
[mariadb]
query_cache_size=0
binlog_format=ROW
default_storage_engine=innodb
innodb_autoinc_lock_mode=2
wsrep_provider=/usr/lib64/galera/libgalera_smm.so
wsrep_cluster_address=gcomm://101.10.101.10,111.11.111.11,121.12.121.12
wsrep_cluster_name='cluster1'
wsrep_node_address='101.10.101.10'
wsrep_node_name='db1'
wsrep_sst_method=rsync
wsrep_sst_auth=<USER_NAME>:<PASSWORD>
....
```

Here the “wsrep_sst_auth” is the username:password of my MariaDB server. Make sure you put proper values at username:password against “wsrep_sst_auth” property.
The same /etc/my.cnf should be pasted in each of the nodes, just we have to change the values of “wsrep_cluster_name” and “wsrep_node_address”.

## Get it started

The very first node, that is the “db1” should be started with below command –

```shell
/etc/init.d/mysql bootstrap
```

The other nodes should be started with the normal command like –

```shell
/etc/init.d/mysql start
```

While starting the other nodes, if you find the message like ‘Starting MySQL….SST in progress, setting sleep higher. SUCCESS! ‘, you are DONE !!! 👍

## Check the Cluster Status

Go to the “db1” and run :

```shell
mysql -uroot -p<YOUR PASSWORD>

show status like 'wsrep%';
```

You will get to see the nodes’ IP and the port currently in the cluster.

```shell
wsrep_incoming_addresses | 101.10.101.10:3306,111.11.111.11:3306,121.12.121.12:3306
```
