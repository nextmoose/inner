#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --configuration-file)
            CONFIGURATION_FILE="${2}" &&
                shift 2
        ;;
        --configuration-volume)
            CONFIGURATION_VOLUME="${2}" &&
                shift 2
        ;;
        *)
            echo Unsupported Option &&
                echo ${0} &&
                echo ${@} &&
                exit 64
        ;;
    esac
done &&
    if [ ! -z "${CONFIGURATION_FILE}" ]
    then
        source "${CONFIGURATION_FILE}"
    fi
    docker \
        container \
        create \
        --name gitlab-runner \
        --restart-always \
        --mount type=volume,source=${CONFIGURATION_VOLUME},destination=/etc/gitlab-runner,readonly=false \
        --env DOCKER_HOST \
        gitlab/gitlab-runner:v10.7.0 &&
    docker network connect main gitlab-runner &&
    docker container start gitlab-runner