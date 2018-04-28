#!/bin/sh

gitlab-runner \
    register \
    --url http://gitlab/ \
    --non-interactive \
    --registration-token jPwoEgyFZzbduZP3JJzM \
    --name special \
    --executor docker \
    --docker-image docker:18.02.0-ce \
    --docker-network-mode main \
    --docker-network-mode special \
    --tag-list "alpha" \
    --env DOCKER_HOST="${DOCKER_HOST}" \
    --docker-host ${DOCKER_HOST}