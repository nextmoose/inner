#!/bin/sh

docker network create main &&
    docker network create gitlab &&
    docker \
        container \
        create \
        --