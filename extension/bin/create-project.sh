#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --repository-name)
            REPOSITORY_NAME="${2}" &&
                shift 2
        ;;
        --repository-description)
            REPOSITORY_DESCRIPTION="${2}" &&
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
    if [ -z "${REPOSITORY_NAME}" ]
    then
        echo Unspecified REPOSITORY_NAME &&
            exit 65
    fi &&
    (
        pass show aws-access-key-id &&
            pass show aws-secret-access-key &&
            echo us-east-1 &&
            echo text
    ) | aws configure &&
    aws codecommit create-repository --repository-name ${REPOSITORY_NAME} --repository-description "${REPOSITORY_DESCRIPTION}"
    
    
    
    
    
    