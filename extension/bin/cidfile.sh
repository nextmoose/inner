#!/bin/sh

CIDFILE=$(mktemp /run/docker/unencrypted/containers/XXXXXXXX) &&
    rm -f ${CIDFILE} &&
    echo ${CIDFILE}