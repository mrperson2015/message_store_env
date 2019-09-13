# #!/usr/bin/env bash

# CONTAINER_NAME="json_data_gen"
# IMAGE="mrperson/message_store_data_gen"

# docker pull $IMAGE:latest

# for container in `docker ps -a --format "{{.Names}}"`;
# do
#     if [ $container == $CONTAINER_NAME ];
#     then
#         echo "Stopping and Removing container [$CONTAINER_NAME]"
#         docker rm --force "$CONTAINER_NAME"
#     fi
# done

# docker run \
#     -it \
#     --name=$CONTAINER_NAME \
#     --restart always \
#     -e http_proxy=http://utmidwsgw.gmaccm.com:8080 \
#     -e https_proxy=http://utmidwsgw.gmaccm.com:8080 \
#     -v `pwd`/docker_data/json_data_generator/conf:/json-data-generator/conf \
#     --network=messagestore_default \
#     $IMAGE:latest \
#     /bin/bash
#     # java -jar json-data-generator-1.4.0.jar exampleMessageStore_simConfig.json

# # echo `pwd`/docker_data/json_data_generator/conf
# # echo $(ls `pwd`/docker_data/json_data_generator/conf)