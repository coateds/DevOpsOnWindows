# Docker

## Installation
* Start as root
* cd /etc/yum.repos.d
* vim docker.repo
```
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
```
* yum update (y to do the upgrades)
* yum install -y docker-engine
* systemctl enable docker
* systemctl start docker
* usermod -a -G docker vagrant  (or other user that should run docker)
* user must logout and login again

Do not run containers as root!!

## Using the docker command
* `docker search [keyword]`
* `docker pull hello-world`  --  downloads the hello-world image
  * see this image with `docker images`
* docker pull centos:centos6
* docker pull nginx:latest
  * running an image that has not been pulled will work. 
  * The pull will happen first if needed
* docker inspect nginx
* docker run hello-world
* docker pull docker/whalesay
* docker run docker/whalesay cowsay hello
  * cowsay is the application that the container is running
  * This demonstrates using docker like a parameterized function
* docker ps (process list)  (currently running)
  * docker ps -a
* docker run -it centos:latest /bin/bash (interactive with the tty terminal)
* docker run -d centos:latest /bin/bash  (disconnected/daemon mode)
  * but the conatiner shuts down, because it does not have a continuous job to perform
* docker run -d nginx:latest
  * runs nginix continuously, so it continues
  * docker inspect [name_from_ps]  -  IP address (for instance) can be found at the end of the output
  * put that IP into firefox on the docker host, and the nginx welcome page comes up!
* docker run --name="MyName" to assign your own name to the container
* docker stop [name]
* docker rm `docker ps -a -q`
* docker rmi coateds/myapache

## Docker ports
* Examples here assume nginx:latest has been pulled to the local docker images list
* Start the container with `docker run -d nginx:latest`
  * `docker ps` to confirm it is running and to get the name (randomly) assigned
  * `docker inspect [name_from_ps] | grep IPAddress` to confirm IP (default = 172.17.0.2)
  * browse to http://172.17.0.2 to confirm nginx is running (yum install and use elinks for text based browsing)
* Basic port redirection
  * `docker run -d --name=WebServer1 -P nginx:latest` will redirect localhost:randomport to port 80 of container
  * therefore http://localhost:[rndport] will work on host browser
  * `docker port WebServer1 $CONTAINERPORT` is another way to see the port redirections on a container
  * `docker run -d --name=WebServer1 -p 8080:80 nginx:latest`
* Mnt a volume from host
  * `docker run -d -p 8080:80 --name=WebServer4 -v /home/vagrant/www:/usr/share/nginx/html nginx:latest`
  * edit an index.html in /home/vagrant/www and it will show up in browser at http://localhost:8080/

## Dockerfile

```
FROM debian:stable
MAINTAINER coateds <coateds@outlook.com>

RUN apt-get update && apt-get upgrade -y && apt-get install apache2 telnet  (builds fewer intermediate containers)
(RUN is used to buuild images)

ENV MYVALUE my-value

EXPOSE 80
EXPOSE 22

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
(CMD is used in instantiated containers as they start)
```

* Create a Dockerfile in its own directory
* `docker build -t coateds/myapache .`
* This process adds to images
  1. The base image if not there: debian:stable
  2. The newly created image from the command, coateds/myapache

## logon to a running container
* I used this process to get the Alpine OS version of a running container
* `docker exec -it [Container ID] bash`
* Then cat /etc/alpine-release