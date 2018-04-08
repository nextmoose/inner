#!/bin/sh

CIDFILE=$(create-docker-id-file) &&
    rm -f ${CIDFILE} &&
    cleanup(){
        docker container stop $(cat ${CIDFILE}) && docker container rm --volumes $(cat ${CIDFILE})
        rm -f ${CIDFILE}
    } &&
    trap cleanup EXIT &&
    export PROJECT_NAME=secrets-01 &&
    export CLOUD9_PORT=10604 &&
    export HOST_NAME=github.com &&
    export HOST_PORT=22 &&
    export EXPIRY="now + 1 month" &&
    while [ ${#} -gt 0 ]
    do
        case ${1} in
            --project-name)
                export PROJECT_NAME="${2}" &&
                    shift 2
            ;;
            --cloud9-port)
                export CLOUD9_PORT="${2}" &&
                    shift 2
            ;;
            --origin-id-rsa)
                export ORIGIN_ID_RSA="$(pass show ${2})" &&
                    shift 2
            ;;
            --origin-organization)
                export ORIGIN_ORGANIZATION="${2}" &&
                    shift 2
            ;;
            --origin-repository)
                export ORIGIN_REPOSITORY="${2}" &&
                    shift 2
            ;;
            --host-name)
                export HOST_NAME="${2}" &&
                    shift 2
            ;;
            --host-port)
                export HOST_PORT="${2}" &&
                    shift 2
            ;;
            --user-name)
                export USER_NAME="${2}" &&
                    shift 2
            ;;
            --user-email)
                export USER_NAME="${2}" &&
                    shift 2
            ;;
            --read-write)
                export READ_WRITE=$(uuidgen) &&
                    shift
            ;;
            --read-only)
                export READ_ONLY=$(uuidgen) &&
                    shift
            ;;
            --expiry)
                export EXPIRY=$(date --date "${2}" +%s) &&
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
    if [ -z "${PROJECT_NAME}" ]
    then
        echo Unspecified PROJECT_NAME &&
            exit 65
    fi &&
    if [ -z "${CLOUD9_PORT}" ]
    then
        echo Unspecified Cloud9 Port &&
            exit 66
    fi &&
    if [ -z "${ORIGIN_ID_RSA}" ]
    then
        echo Unspecified ORIGIN_ID_RSA &&
            exit 67
    fi &&
    if [ -z "${ORIGIN_ORGANIZATION}" ]
    then
        echo Unspecified ORIGIN_ORGANIZATION &&
            exit 68
    fi &&
    if [ -z "${ORIGIN_REPOSITORY}" ]
    then
        echo Unspecified ORIGIN_REPOSITORY &&
            exit 69
    fi &&
    if [ -z "${HOST_NAME}" ]
    then
        echo Unspecified HOST_NAME &&
            exit 70
    fi &&
    if [ -z "${HOST_PORT}" ]
    then
        echo Unspecified HOST_PORT &&
            exit 71
    fi &&
    if [ -z "${USER_NAME}" ]
    then
        echo Unspecified USER_NAME &&
            exit 72
    fi &&
    if [ -z "${USER_EMAIL}" ]
    then
        echo Unspecified USER_EMAIL &&
            exit 73
    fi &&
    if [ -z "${READ_WRITE}" ] && [ -z "${READ_ONLY}" ]
    then
        echo Unspecified READ_WRITE or READ_ONLY &&
            exit 74
    fi &&
    if [ -z "${EXPIRY}" ]
    then
        echo Unspecified EXPIRY &&
            exit 75
    fi &&
    docker \
        container \
        create \
        --cidfile ${CIDFILE} \
        --rm \
        --env PROJECT_NAME \
        --env CLOUD9_PORT \
        --env GPG_SECRET_KEY \
        --env GPG2_SECRET_KEY \
        --env GPG_OWNER_TRUST \
        --env GPG2_OWNER_TRUST \
        --env GPG_KEY_ID \
        --env USER_EMAIL \
        --env ORIGIN_ORGANIZATION \
        --env ORIGIN_REPOSITORY \
        --env ORIGIN_ID_RSA \
        --env HOST_NAME \
        --env HOST_PORT \
        --env USER_NAME \
        --env USER_EMAIL \
        --env READ_WRITE \
        --env READ_ONLY \
        --label expiry=${EXPIRY} \
        rebelplutonium/secret-editor:1.0.0 &&
    docker network connect --alias ${PROJECT_NAME} main $(cat ${CIDFILE}) &&
    docker container start --interactive $(cat ${CIDFILE})
