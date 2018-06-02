#!/bin/sh

sudo dnf install --assumeyes rsync dvdisaster genisoimage &&
    (
        pass show aws-access-key-id &&
            pass show aws-secret-access-key &&
            echo us-east-1 &&
            echo text
            
    ) | aws configure &&
    cd $(mktemp -d /opt/cloud9/workspace/XXXXXXXX) &&
    for I in $(seq 0 6)
    do
        aws s3 cp s3://hp-pavillion/volumes.tar.gz.0${I}.gpg.iso hp-pavillion/volumes.tar.gz.0${I}.gpg.iso &&
            docker container run --interactive --rm --volume $(pwd):/in:ro --volume /srv/host/volumes/user:/out alpine:3.4 cp /in/hp-pavillion/volumes.tar.gz.0${I}.gpg.iso /out/volumes.tar.gz.0${I}.gpg.iso &&
            rm hp-pavillion/volumes.tar.gz.0${I}.gpg.iso
    done