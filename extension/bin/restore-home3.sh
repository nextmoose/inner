#!/bin/sh

PASSPHRASE=${1} &&
    cd $(mktemp -d /opt/cloud9/workspace/XXXXXXXX) &&
    for I in $(seq 0 6)
    do
        docker container run --interactive --volume /srv/host/volumes/user:/in:ro --volume $(pwd):/out alpine:3.4 cp in/volumes.tar.gz.0${I}.gpg out/volumes.tar.gz.0${I}.gpg &&
            echo ${PASSPHRASE} | gpg volumes.tar.gz.0${I}.gpg --passphrase-fd 0 &&
            cat volumes.tar.gz.0${I} >> volumes.tar.gz
    done &&
    gunzip volumes.tar.gz &&
    tar --extract --file volumes.tar &&
    pwd