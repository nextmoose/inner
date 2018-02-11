#!/bin/sh

ps -e -o uid=,pid=,command= | grep "^ *1000 *" | sed "s#^ *1000 *##" | grep " *node /opt/docker/c9sdk/server.js --listen 0.0.0.0 -w /opt/docker/workspace -p ${CLOUD9_PORT}\$" | sed -e "s# *node /opt/docker/c9sdk/server.js --listen 0.0.0.0 -w /opt/docker/workspace -p ${CLOUD9_PORT}\$##" | while read PID
do
    kill ${PID}
done