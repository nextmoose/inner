#!/bin/sh

sudo dnf install --assumeyes rsync dvdisaster genisoimage &&
    (
        pass show aws-access-key-id &&
            pass show aws-secret-access-key &&
            echo us-east-1 &&
            echo text
    ) | aws configure &&
#    cd /tmp/tmp.mtlVfFP63Y &&
    cd $(mktemp -d) &&
    mkdir -p rsync &&
    rsync --archive --delete --progress hpr:/home rsync &&
    tar --create --file home.tar --directory rsync . &&
    sudo rm -rf rsync &&
    gzip -9 home.tar &&
    mkdir splits &&
    split --bytes 450M --numeric-suffixes home.tar.gz splits/home.tar.gz. &&
    rm home.tar.gz &&
    ls -1 splits | while read FILE
    do
        echo ${PASSPHRASE} | gpg --passphrase-fd 0 --sign --encrypt --recipient "Emory Merryman" splits/${FILE} &&
        rm splits/${FILE} &&
        mkisofs -o ${FILE}.gpg.iso -r -J splits/${FILE}.gpg &&
        rm splits/${FILE}.gpg &&
        dvdisaster --image ${FILE}.gpg.iso -mRS01 --redundancy high --create ${FILE}.gpg.iso --ecc ${FILE}.gpg.iso.ecc &&
        aws s3 cp ${FILE}.gpg.iso s3://hp-pavillion/${FILE}.gpg.iso &&
        aws s3 cp ${FILE}.gpg.iso s3://hp-pavillion/${FILE}.gpg.iso.ecc &&
        rm ${FILE}.gpg.iso ${FILE}.gpg.iso.ecc
    done

