@echo OFF

SET CONTAINER_NAME=portainer
SET IMAGE="portainer/portainer"

docker pull %IMAGE%:latest

FOR /F "tokens=* USEBACKQ" %%g IN (`docker container ls -a --format "{{.Names}}"`) do (
    echo %%g=%CONTAINER_NAME%
    IF %%g==%CONTAINER_NAME% (
        echo Stopping and Removing container [%CONTAINER_NAME%]
        docker rm --force "%CONTAINER_NAME%")
    )

docker run ^
    -d ^
    -p 9000:9000 ^
    --name=%CONTAINER_NAME% ^
    --restart always ^
    -v /var/run/docker.sock:/var/run/docker.sock ^
    %IMAGE%:latest ^
    --admin-password="$2y$12$wxhWs2RTCf6wQ59kzfmqUOoFPogTwAkB1AOK05ghWEjJ0GHPfQG0C"

REM address:  localhost:9000
REM username: admin
REM password: password1