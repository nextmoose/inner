#!/bin/sh

cd $(mktemp -d /opt/cloud9/workspace/XXXXXXXX) &&
    docker container run --interactive --volume /srv/host/home/user:/in:ro --volume $(pwd):/out alpine:3.4 cp in/home.tar.gz.gpg out/home.tar.gz.gpg &&
    gpg home.tar.gz.gpg &&
    gunzip home.tar.gz &&
    tar --extract --file home.tar &&
    pwd