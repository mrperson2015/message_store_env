@echo OFF

SET CONTAINER_NAME=msg_store_ingress
SET IMAGE="mrperson/message_store_ingress"

docker pull %IMAGE%:latest

FOR /F "tokens=* USEBACKQ" %%g IN (`docker container ls -a --format "{{.Names}}"`) do (
    IF %%g==%CONTAINER_NAME% (
        echo Stopping and Removing container [%CONTAINER_NAME%]
        docker rm --force "%CONTAINER_NAME%")
    )

docker run ^
    -d ^
    -p 3000:3000 ^
    --name=%CONTAINER_NAME% ^
    --restart always ^
    -e http_proxy=http://utmidwsgw.gmaccm.com:8080 ^
    -e https_proxy=http://utmidwsgw.gmaccm.com:8080 ^
    -e MESSAGE_STORE_USER=message_store ^
    -e MESSAGE_STORE_HOST=msg_store ^
    -e MESSAGE_STORE_DATABASE=message_store ^
    -e MESSAGE_STORE_PASSWORD="" ^
    -e MESSAGE_STORE_PORT=5432 ^
    --network=messagestore_default ^
    %IMAGE%:latest

echo ^-----------^---------------------------^-
echo ^| Key      ^| Value                    ^|
echo ^-----------^---------------------------^-
echo ^| Address  ^| localhost:3000           ^|
echo ^| Address  ^| localhost:3000/messages  ^|
echo ^| Username ^| n/a                      ^|
echo ^| Password ^| n/a                      ^|
echo ^-----------^---------------------------^-
echo ""
REM Sample Body
REM {
REM     "id": "c0e679ae-58a8-4f04-92eb-2f74e67ca242",
REM     "type": "<string>",
REM     "stream_name": "EXIT",
REM     "metadata": {
REM         "correlationId": "a74f1282-6d45-4b18-a02c-d1d92740fadb",
REM         "userId": "6fb3e81c-a635-4f20-9b92-47a9ff4a374b",
REM         "causationId": "1c32da33-02bf-4aef-add9-2c2a789d3fbe"
REM     },
REM     "data": {
REM         "test": "EXIT-c0e679ae-58a8-4f04-92eb-2f74e67ca242",
REM         "timestamp": 1551207953631,
REM         "system": "AUDIT",
REM         "actor": "bob",
REM         "action": "LOGIN",
REM         "objects": [
REM             "Building 1"
REM         ],
REM         "location": {
REM             "lat": -23.3208,
REM             "lon": -115.6147
REM         },
REM         "message": "Entered Building 1"
REM     }
REM }