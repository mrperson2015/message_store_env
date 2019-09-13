@echo OFF

SET CONTAINER_NAME=portainer
SET IMAGE="portainer/portainer"

docker pull %IMAGE%:latest

FOR /F "tokens=* USEBACKQ" %%g IN (`docker container ls -a --format "{{.Names}}"`) do (
    IF %%g==%CONTAINER_NAME% (
        echo Stopping and Removing container [%CONTAINER_NAME%]
        docker rm --force "%CONTAINER_NAME%")
    )

docker run ^
    -d ^
    -p 9000:9000 ^
    --name=%CONTAINER_NAME% ^
    --restart always ^
    -e http_proxy=http://utmidwsgw.gmaccm.com:8080 ^
    -e https_proxy=http://utmidwsgw.gmaccm.com:8080 ^
    -v /var/run/docker.sock:/var/run/docker.sock ^
    --network=messagestore_default ^
    %IMAGE%:latest ^
    --admin-password="$2y$12$wxhWs2RTCf6wQ59kzfmqUOoFPogTwAkB1AOK05ghWEjJ0GHPfQG0C" ^
    -H unix:///var/run/docker.sock

echo ^-----------^------------------^-
echo ^| Key      ^| Value           ^|
echo ^-----------^------------------^-
echo ^| Address  ^| localhost:9000  ^|
echo ^| Username ^| admin           ^|
echo ^| Password ^| password1       ^|
echo ^-----------^------------------^-