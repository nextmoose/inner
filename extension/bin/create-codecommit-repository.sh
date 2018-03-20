#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --repository-name)
            REPOSITORY_NAME="${2}" &&
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
    aws codecommit create-repository --repository-name ${REPOSITORY_NAME}