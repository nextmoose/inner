#!/bin/sh

export PASSPHRASE=${1} &&
    sudo dnf install --assumeyes rsync dvdisaster genisoimage &&
    (
        pass show aws-access-key-id &&
            pass show aws-secret-access-key &&
            echo us-east-1 &&
            echo text
    ) | aws configure &&
#    cd /tmp/tmp.mtlVfFP63Y &&
    (cat <<EOF
rm -rf /tmp/volumes &&
    mkdir -p /tmp/volumes &&
    for VOLUME in \$(docker volume ls --quiet)
    do
        mkdir -p /tmp/volumes/\${VOLUME} &&
            docker run --interactive --rm --volume \${VOLUME}:/in:ro --volume /tmp/volumes/\${VOLUME}:out alpine:3.4 cp -r /in/. /out
    done
EOF
    ) | ssh hpr &&
    cd $(mktemp -d) &&
    mkdir -p rsync &&
    rsync --archive --delete --progress hpr:/tmp rsync &&
    sudo tar --create --file volumes.tar --directory rsync . &&
    sudo rm -rf rsync &&
    gzip -9 volumes.tar &&
    mkdir splits &&
    split --bytes 450M --numeric-suffixes volumes.tar.gz splits/volumes.tar.gz. &&
    rm volumes.tar.gz &&
    ls -1 splits &&
    for FILE in $(ls -1 splits)
    do
        echo ${PASSPHRASE} | gpg --passphrase-fd 0 --sign --encrypt --recipient "Emory Merryman" splits/${FILE} &&
            rm splits/${FILE} &&
            mkisofs -o ${FILE}.gpg.iso -r -J splits/${FILE}.gpg &&
            rm splits/${FILE}.gpg &&
            dvdisaster --image ${FILE}.gpg.iso -mRS01 --redundancy high --create ${FILE}.gpg.iso --ecc ${FILE}.gpg.iso.ecc &&
            while ! aws s3 cp ${FILE}.gpg.iso s3://hp-pavillion/${FILE}.gpg.iso
            do
                echo FAILED TO UPLOAD &&
                    sleep 60s
            done &&
            echo SUCCESSFULLY UPLOADED ${FILE}.gpg.iso &&
            while ! aws s3 cp ${FILE}.gpg.iso.ecc s3://hp-pavillion/${FILE}.gpg.iso.ecc
            do
                echo FAILED TO UPLOAD &&
                    sleep 60s
            done &&
            echo SUCCESSFULLY UPLOADED ${FILE}.gpg.iso.ecc &&
            rm ${FILE}.gpg.iso ${FILE}.gpg.iso.ecc
    done

