#!/bin/sh

gitlab-runner \
    register \
    --url http://gitlab/ \
    --non-interactive \
    --registration-token jPwoEgyFZzbduZP3JJzM \
    --name root \
    --executor docker \
    --docker-image docker:18.02.0-ce \
    --docker-network-mode gitlab_default \
    --docker-host ${DOCKER_HOST}