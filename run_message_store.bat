@echo OFF

SET CONTAINER_NAME=msg_store
SET IMAGE="ethangarofolo/eventide-message-store-postgres"

docker pull %IMAGE%:latest

FOR /F "tokens=* USEBACKQ" %%g IN (`docker container ls -a --format "{{.Names}}"`) do (
    IF %%g==%CONTAINER_NAME% (
        echo Stopping and Removing container [%CONTAINER_NAME%]
        docker rm --force "%CONTAINER_NAME%")
    )

docker run ^
    -d ^
    -p 5432:5432 ^
    --name=%CONTAINER_NAME% ^
    --restart always ^
    -e http_proxy=http://utmidwsgw.gmaccm.com:8080 ^
    -e https_proxy=http://utmidwsgw.gmaccm.com:8080 ^
    --network=messagestore_default ^
    %IMAGE%:latest

echo ^-----------^------------------^-
echo ^| Key      ^| Value           ^|
echo ^-----------^------------------^-
echo ^| Address  ^| localhost:5432  ^|
echo ^| Username ^| msessage_store  ^|
echo ^| Password ^|                 ^|
echo ^-----------^------------------^-