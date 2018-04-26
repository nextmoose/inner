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
        --log-volume)
            LOG_VOLUME="${2}" &&
                shift 2
        ;;
        --data-volume)
            DATA_VOLUME="${2}" &&
                shift 2
        ;;
        *)
            echo Unknown Option &&
                echo ${0} &&
                echo ${@} &&
                exit 64
        ;;
    esac
done &&
    source ${CONFIGURATION_FILE} &&
    docker \
        container \
        create \
        --name gitlab \
        --restart always \
        --mount type=volume,source=${CONFIGURATION_VOLUME},destination=/etc/gitlab,readonly=false \
        --mount type=volume,source=${LOG_VOLUME},destination=/var/log/gitlab,readonly=false \
        --mount type=volume,source=${DATA_VOLUME},destination=/var/opt/gitlab,readonly=false \
        gitlab/gitlab-ce:10.7.1-ce.0 &&
    docker network connect --alias gitlab main gitlab &&
    docker container start gitlab