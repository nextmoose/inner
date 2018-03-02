#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --name)
            export NAME="${2}" &&
                shift 2
        ;;
        --timestamp)
            export TSTAMP="${2}" &&
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
    source /usr/local/bin/artifacts-env &&
    (
        pass show aws-access-key-id &&
            pass show aws-secret-access-key &&
            echo us-east-1 &&
            echo text
    ) | aws configure &&
    mkdir parts &&
    PARTS_COUNT=$(aws s3api get-object --bucket ${BUCKET} --key ${NAME}-${TSTAMP}.tar.gz --part 1 parts/00000001 --query "PartsCount") &&
    seq 2 ${PARTS_COUNT} | while read PART
    do
        aws s3api get-object --bucket ${BUCKET} --key ${NAME}-${TSTAMP}.tar.gz --part ${PART} parts/$(printf %08d ${PART})
    done &&
    cat parts/* > ${NAME}-${TSTAMP}.tar.gz &&
    gunzip ${NAME}-${TSTAMP}.tar.gz &&
    tar --extract --file ${NAME}-${TSTAMP}.tar