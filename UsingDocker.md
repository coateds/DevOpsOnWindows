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
* docker inspect nginx
* docker run hello-world