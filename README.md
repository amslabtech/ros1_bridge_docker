# ros1_bridge_docker
[![Build Status](https://travis-ci.org/amslabtech/ros1_bridge_docker.svg?branch=master)](https://travis-ci.org/amslabtech/ros1_bridge_docker)

Docker image for ros1_bridge

Docker images are available on [Dockerhub](https://cloud.docker.com/u/amslabtech/repository/docker/amslabtech/ros1_bridge)

## Requirement
- Docker

## Install and build
```
git clone https://github.com/amslabtech/ros1_bridge_docker
cd ros1_bridge_docker
./build.sh
```
you can also pull docker image from dockerhub
```
docker pull amslabtech/ros1_bridge:dashing
```

## How to use
```
cd ros1_bridge_docker
./run_docker.sh dashing
```
