#!/bin/sh

dnf update --assumeyes &&
    dnf install --assumeyes dnf-plugins-core sudo &&
    dnf install --assumeyes python2-pip &&
    dnf install --assumeyes gnupg gnupg pass findutils &&
    dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo &&
    dnf install --assumeyes docker-common docker-latest &&
    dnf install --assumeyes man &&
    dnf install --assumeyes paperkey a2ps &&
    dnf install --assumeyes gnucash fuse-sshfs &&
    dnf install --assumeyes procps-ng &&
    sed -i "s+^# user_allow_other\$+user_allow_other+" /etc/fuse.conf &&
    curl http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo > /etc/yum.repos.d/virtualbox.repo &&
    dnf update --assumeyes &&
    dnf install --assumeyes binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms &&
    dnf install --assumeyes VirtualBox-5.2 &&
    /usr/lib/virtualbox/vboxdrv.sh setup &&
    usermod -a -G vboxusers user &&
    dnf clean all