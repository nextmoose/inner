#!/bin/sh

for I in $(seq 0 6)
do
    mkdir -p mount.0${I} &&
        sudo mount -o loop volumes.tar.gz.0${I}.gpg.iso mount.0${I} &&
        cp mount.0${I}/volumes.tar.gz.0${I}.gpg volumes.tar.gz.0${I}.gpg &&
        sleep 10 &&
        sudo umount mount.0${I}
done