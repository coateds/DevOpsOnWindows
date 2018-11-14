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

Manual steps:
* groupadd docker??
* usermod -aG docker cloud_user

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

## some commands
* docker commit
* docker create
* [network links]
* docker network create --driver=bridge --subnet=192.168.10.0/24 --gateway=192.168.10.250 borkspace
* docker network inspect borkspce
* docker run -it --name treattransfer --network=borkspace spacebones/myancat  -- run a container connected to a network
* docker volume create missionstatus
  * docker volume ls
  * docker inspect missionstatus
  * docker run -d -p 80:80 --name fishin-mission --mount source=missionstatus,target=/usr/local/apache2/htdocs httpd
* Logging
  * /etc/rsyslog.conf
  * systemctl start rsyslog
  * /etc/docker/daemon.json
  ```json
  {
    "log-driver": "syslog",
    "log-opts": {
      "syslog-address": "udp://10.0.1.9:514"
    }
  }
  ```
  * tail /var/log/messages
  * docker container run -d --name syslog-logging httpd
  * docker logs syslog-logging (does not work as logs redirected to syslog)
  * docker container run -d --name json-logging --log-driver json-file httpd
  * docker logs json-logging
* Watchtower
  * Watchtower is a container that updates all running containers when changes are made to the image that it is running
  * Docs:  https://github.com/v2tec/watchtower
  ```dockerfile
  FROM node
  
  RUN mkdir -p /var/node
  ADD content-express-demo-app/ /var/node/
  WORKDIR /var/node
  RUN npm install
  CMD ./bin/www
  ```
  * docker login
  * docker push coateds/express
  * docker run -d --name demo-app -p 80:3000 --restart always coateds/express
  * docker run -d --name watchtower --restart always -v /var/run/docker.sock:/var/run/docker.sock v2tec/watchtower -i 30
* Metadata, Labels and arguments
```dockerfile
FROM node

LABEL maintainer="coateds@outlook.com"

ARG BUILD_VERSION
ARG BUILD_DATE
ARG APPLICATION_NAME

LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.application=$APPLICATION_NAME
LABEL org.label-schema.version=$BUILD_VERSION

RUN mkdir -p /var/node
ADD weather-app/ /var/node/
WORKDIR /var/node
RUN npm install
EXPOSE 3000
CMD ./bin/www
```
  * docker build -t coateds/weather-app --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') --build-arg APPLICATION_NAME=weather-app --build-arg BUILD_VERSION=v1.0 -f Dockerfile .
* Docker Compose
  * docker-compose.yml

```
  version: '3.2'
  services:
    weather-app1:
      build: ./weather-app
      tty: true
      networks:
        - frontend
    weather-app2:
      build: ./weather-app
      tty: true
      networks:
        - frontend
    weather-app3:
      build: ./weather-app
      tty: true
      networks:
        - frontend
    loadbalancer:
      build: ./load-balancer
      tty: true
      ports:
        - 80:80
      networks:
        - frontend
  
  networks:
    frontend:
```
* nginx.conf
```
events { worker_connections 1024; }

http {
 upstream localhost {
    server weather-app1:3000;
    server weather-app2:3000;
    server weather-app3:3000;

 }
 server {
   listen 80:
   server_name localhost;
   location / {
     proxy_pass http://localhost;
     proxy_set_header Host $host;
   }
 }
}
```

* docker-compose up --build -d


 