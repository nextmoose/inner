#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --domain)
            DOMAIN="${2}" &&
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
    IDFILE=$(mktemp /srv/docker/${1}/XXXXXXXX) &&
    rm -f ${IDFILE} &&
    echo ${IDFILE}