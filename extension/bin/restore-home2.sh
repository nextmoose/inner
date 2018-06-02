#!/bin/sh

for I in $(seq 0 6)
do
    mkdir -p mount.0${I} &&
        sudo mount -o loop home.tar.gz.0${I}.gpg.iso mount.0${I} &&
        cp mount.0${I}/home.tar.gz.0${I}.gpg home.tar.gz.0${I}.gpg &&
        sleep 10 &&
        sudo umount mount.0${I}
done