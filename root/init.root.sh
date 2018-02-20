#!/bin/sh

mkdir /srv/docker/{containers,images,networks,volumes,workspaces} &&
    chown user:user /srv/docker/{containers,images,networks,volumes,workspaces}