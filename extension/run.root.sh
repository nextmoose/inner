#!/bin/sh

dnf update --assumeyes &&
    dnf install --assumeyes dnf-plugins-core sudo &&
    dnf install --assumeyes python2-pip &&
    dnf install --assumeyes gnupg gnupg pass findutils &&
    dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo &&
    dnf install --assumeyes docker-common docker-latest &&
    dnf install --assumeyes man &&
    dnf install --assumeyes procps-ng &&
    dnf install --assumeyes iputils &&
    dnf clean all