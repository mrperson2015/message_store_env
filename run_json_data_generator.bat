@echo OFF

SET CONTAINER_NAME=json_data_gen
SET IMAGE="mrperson/message_store_data_gen"

docker pull %IMAGE%:latest

FOR /F "tokens=* USEBACKQ" %%g IN (`docker container ls -a --format "{{.Names}}"`) do (
    IF %%g==%CONTAINER_NAME% (
        echo Stopping and Removing container [%CONTAINER_NAME%]
        docker rm --force "%CONTAINER_NAME%")
    )

docker run ^
    -d ^
    --name=%CONTAINER_NAME% ^
    --restart always ^
    -e http_proxy=http://utmidwsgw.gmaccm.com:8080 ^
    -e https_proxy=http://utmidwsgw.gmaccm.com:8080 ^
    -v %cd%/docker_data/json_data_generator/conf:/json-data-generator/conf ^
    --network=messagestore_default ^
    %IMAGE%:latest ^
    java -jar json-data-generator-1.4.0.jar exampleMessageStore_simConfig.json