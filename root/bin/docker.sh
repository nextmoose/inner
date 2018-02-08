#!/bin/sh

/usr/bin/docker \
    container \
    run \
    --interactive \
    --tty \
    --rm \
    docker:${DOCKER_SEMVER}-ce \
        "${@}"