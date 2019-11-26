#!/bin/bash

#for debian buster
#fai config and server prepare
cp -r fai/* /etc/fai/
cp -r fai/apt/* /etc/apt/

#gpg keys
cp fai/apt/trusted.gpg.d/deepin-archive-keyring.gpg /usr/share/keyrings/
cp fai/apt/trusted.gpg.d/ubuntu-archive-keyring.gpg /usr/share/keyrings/

#debootstap patch
#DEEPIN is forked from Debian SID
cp fai/panda /usr/share/debootstrap/scripts/
cp fai/lion /usr/share/debootstrap/scripts/
#BONIC
cp fai/bionic /usr/share/debootstrap/scripts/

#system update,need reboot
apt-get update -y
apt-get dist-upgrade -t buster-backports -y
apt-get install -t buster-backports -y linux-image-amd64 linux-headers-amd64

#nfsroot reinsall
fai-setup -f -v

#pxe menu
cp extra/pxelinux.cfg/default /srv/tftp/fai/pxelinux.cfg/default

#pxe files
cp /usr/lib/syslinux/modules/bios/* /srv/tftp/fai/

#static files for web server
#mkdir /srv/web
#jdk-8u161-linux-x64.rpm  jdk-8u161-linux-x64.tar.gz
#coreos pxe
