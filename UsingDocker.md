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

Using the `docker` command
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