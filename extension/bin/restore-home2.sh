#!/bin/sh

for I in $(seq 0 6)
do
    rm -rf mount &&
        mkdir -p mount &&
        sudo mount -o loop home.tar.gz.0${I}.gpg.iso mount &&
        cp mount/home.tar.gz.0${I}.gpg home.tar.gz.0${I}.gpg &&
        sleep 10 &&
        sudo umount mount
done