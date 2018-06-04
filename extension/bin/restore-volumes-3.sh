#!/bin/sh

(
    pass show aws-access-key-id &&
        pass show aws-secret-access-key &&
        echo us-east-1 &&
        echo text
        
) | aws configure &&
    PASSPHRASE=${1} &&
    cd $(mktemp -d /opt/cloud9/workspace/XXXXXXXX) &&
    for I in $(aws s3 ls hp-pavillion | grep volumes.tar.gz | grep "iso\$" | sed -e "s#^.*volumes.tar[.]gz[.]##" | sed -e "s#[.]gpg[.]iso\$##")
    do
        docker container run --interactive --volume /srv/host/home/user:/in:ro --volume $(pwd):/out alpine:3.4 cp in/volumes.tar.gz.${I}.gpg out/volumes.tar.gz.${I}.gpg &&
            echo ${PASSPHRASE} | gpg --passphrase-fd 0 volumes.tar.gz.${I}.gpg &&
            cat volumes.tar.gz.${I} >> home.tar.gz
    done &&
    gunzip volumes.tar.gz &&
    tar --extract --file volumes.tar &&
    pwd