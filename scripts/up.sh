#!/bin/sh

docker     volume     create     --label "volume.expiration=never"     --label "volume.retention=always"     --label "snapshot.expiry=1 week"     --label "snapshot.retention=1 day"     --label "archive.shallow.expiry=1 week"     --label "archive.shallow.retention=1 month"     --label "archive.deep.expiry=1 month"     --label "archive.deep.retention=1 year"     docker         container         create         --name browser         --mount 
    docker network create main &&
    docker network create gitlab &&
    docker network connect main browser &&
    docker container start browser
