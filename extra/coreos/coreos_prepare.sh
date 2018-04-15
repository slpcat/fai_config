#!/bin/bash

#time and locale
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# netdata monitor
bash <(curl -Ss https://my-netdata.io/kickstart-static64.sh) --dont-wait all

#add certs for registry

