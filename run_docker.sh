#!/bin/bash

tag="latest"

if [ $# -ne 1 ]; then
    echo "docker container tag is not specified"
    echo "default tag 'latest' will be used"
else
    tag=$1
fi

IMAGE_NAME="amslabtech/ros1_bridge:${tag}"

echo $IMAGE_NAME

docker run -it --rm \
  --net="host" \
  --name=ros1_bridge_container \
  $IMAGE_NAME
