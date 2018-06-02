#!/bin/sh

PASSPHRASE=${1} &&
    cd $(mktemp -d /opt/cloud9/workspace/XXXXXXXX) &&
    for I in $(seq 0 6)
    do
        docker container run --interactive --volume /srv/host/home/user:/in:ro --volume $(pwd):/out alpine:3.4 cp in/home.tar.gz.0${I}.gpg out/home.tar.gz.0${I}.gpg &&
            echo ${PASSPHRASE} | gpg home.tar.gz.0${I}.gpg --passphrase-fd 0 &&
            cat home.tar.gz.0${I} >> home.tar.gz
    done &&
    gunzip home.tar.gz &&
    tar --extract --file home.tar &&
    pwd