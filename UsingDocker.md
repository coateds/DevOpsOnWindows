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

* Swarm
  * From swarm-token.txt copy something similar to:
  * `docker swarm join --token SWMTKN-1-0h5r2aortfi3qcl7fv908plujq2n9xd1o22g3cryup8bo2pbbu-0vcfmhusrnaxjsp06x197eiju 10.0.1.249:2377`
  * Paste in to swarm worker node shell (as root)
  * back at first node:  docker service create --name nginx-app --publish published=8080,target=80 --replicas=2 nginx
 

 * Another docker-compose file
 ```
version: '3'
services:
  ghost:
    image: ghost:1-alpine
    container_name: ghost-blog
    restart: always
    ports:
     - 80:2368
    environment:
      database__client: mysql
      database__connection__host: mysql
      database__connection__user: root
      database__connection__password: P4sSw0rd0!
      database__connection__database: ghost
    volumes:
      - ghost-volume:/var/lib/ghost
    depends_on:
      - mysql

  mysql:
    image: mysql:5.7
    container_name: ghost-db
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: P4sSw0rd0!
    volumes:
      - mysql-volume:/var/lib/mysql

volumes:
  ghost-volume:
  mysql-volume:
 ```

 * docker-compose up -d


* Prometheus
* prometheus.yml
```
scrape_configs:
  - job_name: cadvisor
    scrape_interval: 5s
    static_configs:
      - targets:
        - cadvisor:8080
```
* Another docker-compose.yml file
```
version: '3'
services:
  prometheus:
    image: prom/prometheus:latest
    container_name: prometheus
    ports:
      - 9090:9090
    command:
      - --config.file=/etc/prometheus/prometheus.yml
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
    depends_on:
      - cadvisor

  cadvisor:
    image: google/cadvisor:latest
    container_name: cadvisor
    ports:
      - 8080:8080
    volumes:
      - /:/rootfs:ro
      - /var/run:/var/run:rw
      - /sys:/sys:ro
      - /var/lib/docker:/var/lib/docker:ro
```

end result: port 9090 for prometheus and 8080 for cadvisor

* Docker stats (like using top)
* stats.sh
```bash
#! /bin/bash

docker stats --format "table {{.Name}} {{.ID}} {{.MemUsage}} {{.CPUPerc}}"
```

* Grafana
/etc/docker/daemon.json
```
{
  "metrics-addr": "0.0.0.0:9323",
  "experimental": true
}
```
prometheus.yml
```
scrape_configs:
- job_name: prometheus
  scrape_interval: 5s
  static_configs:
  - targets:
    - prometheus:9090
    - node-exporter:9100
    - pushgateway:9091
    - cadvisor:8080
- job_name: docker
  scrape_interval: 5s
  static_configs:
  - targets:
    - 10.0.1.63:9323
```

docker-compose
```
version: '3'
services:
  prometheus:
    image: prom/prometheus:latest
    container_name: prometheus
    ports:
      - 9090:9090
    command:
      - --config.file=/etc/prometheus/prometheus.yml
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml:ro
    depends_on:
      - cadvisor
  cadvisor:
    image: google/cadvisor:latest
    container_name: cadvisor
    ports:
      - 8080:8080
    volumes:
      - /:/rootfs:ro
      - /var/run:/var/run:rw
      - /sys:/sys:ro
      - /var/lib/docker/:/var/lib/docker:ro
  pushgateway:
    image: prom/pushgateway:latest
    container_name: pushgateway
    ports:
      - 9091:9091
  node-expoerter:
    image: prom/node-exporter:latest
    container_name: node-exporter
    ports:
      - 9100:9100
  grafana:
    image: grafana/grafana:latest
    container_name: grafana
    ports:
      3000:3000
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=password
    depends_on:
      - prometheus
      - cadvisor
```

* More on Swarm
* On the first swarm server (swarm master?):  `docker swarm init`
* Generates a command for other servers:
* `docker swarm join --token SWMTKN-1-2fd3jsjjuouzsw9t4t7huvgqfufkzphiuulp54dove7c5f5xym-dxecvn78jm5zk9kbgzta52vfd 10.0.1.24:2377`
* (on swarm master) docker node ls
* `docker service create --name weather-app --publish published=80,target=3000 --replicas=3 weather-app`
* `docker service ls`
* scale up a service(backup): `docker service scale backup=3`
* `docker service ps backup`
* Backup  -- This one did not entirely work
  * `systemctl stop docker`
  * `tar czvf swarm.tgz /var/lib/docker/swarm/`
  * scp the tarball from the master to the backup in /var/lib/docker
  * restart docker
  *  docker swarm init --force-new-cluster
  * docker swarm leave
  * docker node ls
  * `docker service scale backup=1`

  * Swarm Scaling
    * docker swarm init
    * Master 1: `docker swarm init`
      * `docker swarm join-token manager`
      * `docker swarm join --token SWMTKN-1-1eg4ao5beydlurkik4l2bhnfpfh4w977nxptwk45pt7663z47c-34rewq6hu6z0ousa5v17l6cl8 10.0.1.103:2377`
    * for worker nodes only:
    * `docker swarm join --token SWMTKN-1-1eg4ao5beydlurkik4l2bhnfpfh4w977nxptwk45pt7663z47c-awpov5rpjjieh8gx4vidgpvwj 10.0.1.103:2377`
    * `docker node ls`
```
ID                            HOSTNAME                     STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
xybnsj12am6pkobcvzxwgoext *   ip-10-0-1-103.ec2.internal   Ready               Active              Leader              18.06.0-ce (master1)
tk835r59nhcogteagrr0jix3i     ip-10-0-1-128.ec2.internal   Ready               Active                                  18.06.0-ce
s93xpt46zufpzruxextj68auz     ip-10-0-1-168.ec2.internal   Ready               Active              Reachable           18.06.0-ce (master2)
1w83fn6rc6ceno35pn8730r7e     ip-10-0-1-181.ec2.internal   Ready               Active                                  18.06.0-ce
s4sdnbebovpt7cq855p4swbxm     ip-10-0-1-219.ec2.internal   Ready               Active                                  18.06.0-ce
```
* These nodes will not participate in running service
  * docker node update --availability drain xybnsj12am6pkobcvzxwgoext
  * docker node update --availability drain s93xpt46zufpzruxextj68auz
* docker service create --name httpd -p 80:80 --replicas 3 httpd
*  docker service ps httpd
```
ID                  NAME                IMAGE               NODE                         DESIRED STATE       CURRENT STATE            ERROR               PORTS
9dftknu9bv81        httpd.1             httpd:latest        ip-10-0-1-219.ec2.internal   Running             Running 46 seconds ago
n8m6bxbfjpu3        httpd.2             httpd:latest        ip-10-0-1-128.ec2.internal   Running             Running 46 seconds ago
j6jr7qjrm9ki        httpd.3             httpd:latest        ip-10-0-1-181.ec2.internal   Running             Running 46 seconds ago
```
* docker service scale httpd=5
* docker service ps httpd
```
ID                  NAME                IMAGE               NODE                         DESIRED STATE       CURRENT STATE                ERROR               PORTS
9dftknu9bv81        httpd.1             httpd:latest        ip-10-0-1-219.ec2.internal   Running             Running 4 minutes ago
n8m6bxbfjpu3        httpd.2             httpd:latest        ip-10-0-1-128.ec2.internal   Running             Running 4 minutes ago
j6jr7qjrm9ki        httpd.3             httpd:latest        ip-10-0-1-181.ec2.internal   Running             Running 4 minutes ago
ucala1avn1ex        httpd.4             httpd:latest        ip-10-0-1-181.ec2.internal   Running             Running about a minute ago
l0yat3ld6cmb        httpd.5             httpd:latest        ip-10-0-1-128.ec2.internal   Running             Running about a minute ago
```
* docker service scale httpd=2
* docker service ps httpd
```
ID                  NAME                IMAGE               NODE                         DESIRED STATE       CURRENT STATE           ERROR               PORTS
9dftknu9bv81        httpd.1             httpd:latest        ip-10-0-1-219.ec2.internal   Running             Running 5 minutes ago
n8m6bxbfjpu3        httpd.2             httpd:latest        ip-10-0-1-128.ec2.internal   Running             Running 5 minutes ago
```

# Docker on AWS
* https://aws.amazon.com/getting-started/tutorials/deploy-docker-containers/