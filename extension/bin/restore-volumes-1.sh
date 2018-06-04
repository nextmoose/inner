#!/bin/sh

sudo dnf install --assumeyes rsync dvdisaster genisoimage &&
    (
        pass show aws-access-key-id &&
            pass show aws-secret-access-key &&
            echo us-east-1 &&
            echo text
            
    ) | aws configure &&
    cd $(mktemp -d /opt/cloud9/workspace/XXXXXXXX) &&
    for I in $(aws s3 ls hp-pavillion | grep volumes.tar.gz | grep "iso\$" | sed -e "s#^.*volumes.tar[.]gz[.]##" | sed -e "s#[.]gpg[.]iso\$##")
    do
        aws s3 cp s3://hp-pavillion/volumes.tar.gz.${I}.gpg.iso hp-pavillion/volumes.tar.gz.${I}.gpg.iso &&
            docker container run --interactive --rm --volume $(pwd):/in:ro --volume /srv/host/volumes/user:/out alpine:3.4 cp /in/hp-pavillion/volumes.tar.gz.${I}.gpg.iso /out/volumes.tar.gz.${I}.gpg.iso &&
            rm hp-pavillion/volumes.tar.gz.${I}.gpg.iso
    done