#!/usr/bin/env bash

CONTAINER_NAME="msg_store_ingress"
IMAGE="mrperson/message_store_ingress"

docker pull $IMAGE:latest

for container in `docker ps -a --format "{{.Names}}"`;
do
    if [ $container == $CONTAINER_NAME ];
    then
        echo "Stopping and Removing container [$CONTAINER_NAME]"
        docker rm --force "$CONTAINER_NAME"
    fi
done

docker run \
    -d \
    -p 3000:3000 \
    --name=$CONTAINER_NAME \
    --restart always \
    -e http_proxy=http://utmidwsgw.gmaccm.com:8080 \
    -e https_proxy=http://utmidwsgw.gmaccm.com:8080 \
    --network=messagestore_default \
    $IMAGE:latest


echo "------------------------------"
echo "| Key      | Value           |"
echo "------------------------------"
echo "| Address  | localhost:3000  |"
echo "| Username | n/a             |"
echo "| Password | n/a             |"
echo "------------------------------"
