#!/bin/sh

sudo dnf install --assumeyes rsync dvdisaster genisoimage &&
    (
        pass show aws-access-key-id &&
            pass show aws-secret-access-key &&
            echo us-east-1 &&
            echo text
    ) | aws configure &&
    cd $(mktemp -d /opt/docker/workspace/XXXXXXXX) &&
    seq 0 6 | while read I
    do
        aws s3 cp s3://hp-pavillion/home.tar.gz.0${I}.gpg.iso hp-pavillion/home.tar.gz.0${I}.gpg.iso &&
            docker container run -it --rm --volume $(pwd);/in:ro --volume /srv/host/home/user:/out alpine:3.4 cp /in/home.tar.gz.0${I}.gpg.iso &&
            rm home.tar.gz.0${I}.gpg.iso
    done