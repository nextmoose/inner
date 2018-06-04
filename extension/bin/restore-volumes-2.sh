#!/bin/sh

cd ~
for FILE in $(ls -1 volumes.tar.gz.*.gpg.iso)
do
    mkdir -p mount.${FILE} &&
        sudo mount -o loop ${FILE} mount.${FILE} &&
        GPG_FILE=${FILE%.*} &&
        cp mount.${FILE}/${GPG_FILE} ${GPG_FILE} &&
        sleep 1 &&
        sudo umount mount.${FILE} &&
        rm -rf mount.${FILE}
done