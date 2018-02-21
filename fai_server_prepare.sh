#!/bin/bash

#fai config and server prepare
cp -r fai/* /etc/fai/
cp -r fai/apt/* /etc/apt/

#gpg keys
cp fai/apt/trusted.gpg.d/deepin-archive-keyring.gpg /usr/share/keyrings/

#debootstap patch
#DEEPIN is forked from Debian SID
cp fai/panda /usr/share/debootstrap/scripts/

#system update,need reboot
apt update -y
apt -y dist-upgrade

#nfsroot reinsall
fai-setup -f -v

#pxe menu
cp pxelinux.cfg/default /srv/tftp/fai/pxelinux.cfg/default
