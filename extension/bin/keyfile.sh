#!/bin/sh

KEYFILE=$(mktemp /run/docker/encrypted/keys/XXXXXXXX) &&
    uuidgen > ${KEYFILE} &&
    echo ${KEYFILE}