#!/bin/sh

ls -1 /home/user/docker/containers | while read FILE
do
    sudo /usr/bin/docker container stop $(cat /home/user/docker/containers/${FILE}) &&
        sudo /usr/bin/docker container rm --volumes $(cat /home/user/docker/containers/${FILE}) &&
        rm -f /home/user/docker/${FILE}
done &&
    ls -1 /home/user/docker/images | while read FILE
    do
        sudo /usr/bin/docker image rm $(cat /home/user/docker/images/${FILE}) &&
            rm -f /home/user/docker/${FILE}
    done &&
    ls -1 /home/user/docker/networks | while read FILE
    do
        sudo /usr/bin/docker network rm $(cat /home/user/docker/networks/${FILE}) &&
            rm -f /home/user/docker/${FILE}
    done &&
    ls -1 /home/user/docker/volumes | while read FILE
    do
        sudo /usr/bin/docker volume rm $(cat /home/user/docker/volumes/${FILE}) &&
            rm -f /home/user/docker/${FILE}
    done
        