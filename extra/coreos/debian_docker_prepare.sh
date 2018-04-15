#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

# from https://raw.githubusercontent.com/dcos/dcos/1.10/cloud_images/centos7/install_prereqs.sh
# modified by slpcat@qq.com
# support ubuntu16.04 debian8 and debian9

echo ">>> Set timezone Asia/Shanghai"
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

echo ">>> Enable ntp time sync"
timedatectl set-ntp true

echo ">>> Use latest kernel" 
apt-get update -y
apt-get dist-upgrade -y
apt-get install -y lsb-release sudo
codename=`lsb_release -c -s`
case "$codename" in
xenial)
    apt-get install -y linux-image-4.13.0-17-generic linux-headers-4.13.0-17-generic
    ;;
jessie)
    sed -i /backports/d /etc/apt/sources.list
cat << 'EOF' > /etc/apt/sources.list.d/backports.list
deb http://mirrors.aliyun.com/debian jessie-backports main contrib non-free
deb-src http://mirrors.aliyun.com/debian jessie-backports main contrib non-free
EOF
    apt-get update -y
    apt-get install -t jessie-backports -y linux-base linux-image-4.9.0-0.bpo.4-amd64 linux-headers-4.9.0-0.bpo.4-amd64
    ;; 
stretch)
    sed -i /backports/d /etc/apt/sources.list
cat << 'EOF' > /etc/apt/sources.list.d/backports.list
deb http://mirrors.aliyun.com/debian stretch-backports main contrib non-free
deb-src http://mirrors.aliyun.com/debian stretch-backports main contrib non-free
EOF
    apt-get update -y
    apt-get install -y linux-image-4.13.0-0.bpo.1-amd64 linux-headers-4.13.0-0.bpo.1-amd64
    ;;
*)
    echo "unsupported system " && exit 1
esac

echo ">>> Set grub2 options"
sed -i 's/GRUB_CMDLINE_LINUX=.*$/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"/' /etc/default/grub
update-grub

echo ">>> Set kernel parameters for docker"
sed -i /net.ipv4.ip_forward/d /etc/sysctl.conf
cat << 'EOF' > /etc/sysctl.d/10-docker.conf
net.ipv4.ip_forward=1
net.bridge.bridge-nf-call-ip6tables=1
net.bridge.bridge-nf-call-iptables=1
EOF

echo ">>> Adjusting SSH Daemon Configuration"

#sed -i '/^\s*PermitRootLogin /d' /etc/ssh/sshd_config
#echo -e "\nPermitRootLogin without-password" >> /etc/ssh/sshd_config

sed -i '/^\s*UseDNS /d' /etc/ssh/sshd_config
echo -e "\nUseDNS no" >> /etc/ssh/sshd_config

echo ">>> Installing DC/OS dependencies and essential packages"
apt-get install -y perl tar xz-utils unzip curl dnsutils net-tools ipset rsync 

echo ">>> Disable rsyslog"
systemctl disable rsyslog

echo ">>> Set journald limits"
mkdir -p /etc/systemd/journald.conf.d/
echo -e "[Journal]\nSystemMaxUse=15G" > /etc/systemd/journald.conf.d/dcos-el7-ami.conf

echo ">>> Removing tty requirement for sudo"
sed -i'' -E 's/^(Defaults.*requiretty)/#\1/' /etc/sudoers

echo ">>> Install Docker"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
case "$codename" in
xenial)
    #echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable" > /etc/apt/sources.list.d/docker-ce.list
    #apt-get update -y
    #apt-get install -y docker-ce
    #install docker 1.13
    apt-get install -y docker.io
    ;;
jessie)
    echo "deb [arch=amd64] https://download.docker.com/linux/debian jessie stable" > /etc/apt/sources.list.d/docker-ce.list
    apt-get update -y
    apt-get install -y docker-ce
    ;;
stretch)
    echo "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" > /etc/apt/sources.list.d/docker-ce.list
    apt-get update -y
    apt-get install -y docker-ce
    ;;
*)
    echo "unsupported system " && exit 1
esac



echo ">>> Creating docker config"
mkdir -p /etc/docker
cat << 'EOF' > /etc/docker/daemon.json
{ "insecure-registries":["registry.marathon.l4lb.thisdcos.directory:5000", "gitlab.marathon.l4lb.thisdcos.directory:50000"],
  "live-restore": true,
  "storage-driver": "overlay2",
  "storage-opts": ["overlay2.override_kernel_check=true"],
  "oom-score-adjust": -500,
  "debug": false
}
EOF

systemctl enable docker

echo ">>> Creating docker group"
/usr/sbin/groupadd -f docker

echo ">>> Customizing Docker storage driver to use Overlay"
docker_service_d=/etc/systemd/system/docker.service.d
mkdir -p "$docker_service_d"
cat << 'EOF' > "${docker_service_d}/execstart.conf"
[Service]
Restart=always
StartLimitInterval=0
RestartSec=15
ExecStartPre=-/sbin/ip link del docker0
ExecStart=
ExecStart=/usr/bin/dockerd --graph=/var/lib/docker
EOF

echo ">>> Adding group [nogroup]"
/usr/sbin/groupadd -f nogroup

#echo ">>> Cleaning up SSH host keys"
#shred -u /etc/ssh/*_key /etc/ssh/*_key.pub

echo ">>> Cleaning up accounting files"
rm -f /var/run/utmp
>/var/log/lastlog
>/var/log/wtmp
>/var/log/btmp

echo ">>> Remove temporary files"
apt-get clean all
rm -rf /tmp/* /var/tmp/*

#echo ">>> Remove ssh client directories"
#rm -rf /home/*/.ssh /root/.ssh

echo ">>> Remove history"
unset HISTFILE
rm -rf /home/*/.*history /root/.*history

echo ">>> Update /etc/hosts on boot"
update_hosts_script=/usr/local/sbin/dcos-update-etc-hosts
update_hosts_unit=/etc/systemd/system/dcos-update-etc-hosts.service

mkdir -p "$(dirname $update_hosts_script)"

cat << 'EOF' > "$update_hosts_script"
#!/bin/bash
export PATH=/opt/mesosphere/bin:/sbin:/bin:/usr/sbin:/usr/bin
curl="curl -s -f -m 30 --retry 3"
fqdn=$($curl http://169.254.169.254/latest/meta-data/local-hostname)
ip=$($curl http://169.254.169.254/latest/meta-data/local-ipv4)
echo "Adding $fqdn if $ip is not in /etc/hosts"
grep ^$ip /etc/hosts > /dev/null || echo -e "$ip\t$fqdn ${fqdn%%.*}" >> /etc/hosts
EOF

chmod +x "$update_hosts_script"

cat << EOF > "$update_hosts_unit"
[Unit]
Description=Update /etc/hosts with local FQDN if necessary
After=network.target

[Service]
Restart=no
Type=oneshot
ExecStart=$update_hosts_script

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable $(basename "$update_hosts_unit")


# Make sure we wait until all the data is written to disk, otherwise
# Packer might quite too early before the large files are deleted
sync
echo ">>> Docker runtime is prepared, please reboot"
