#!/usr/bin/env bash

CONTAINER_NAME="portainer"
IMAGE="portainer/portainer"

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
    -p 9000:9000 \
    --name=$CONTAINER_NAME \
    --restart always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    $IMAGE:latest \
    --admin-password='$2y$12$wxhWs2RTCf6wQ59kzfmqUOoFPogTwAkB1AOK05ghWEjJ0GHPfQG0C'

# address:  localhost:9000
# username: admin
# password: password1