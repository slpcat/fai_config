#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

# from https://raw.githubusercontent.com/dcos/dcos/1.10/cloud_images/centos7/install_prereqs.sh
# modified by slpcat@qq.com
echo ">>> Enable ntp time sync"
timedatectl set-ntp true
echo ">>> Use latest kernel from elrepo" 
cat << 'EOF' > /etc/yum.repos.d/elrepo.repo
### Name: ELRepo.org Community Enterprise Linux Repository for el7
### URL: http://elrepo.org/

[elrepo]
name=ELRepo.org Community Enterprise Linux Repository - el7
baseurl=http://elrepo.org/linux/elrepo/el7/$basearch/
	http://mirrors.coreix.net/elrepo/elrepo/el7/$basearch/
	http://jur-linux.org/download/elrepo/elrepo/el7/$basearch/
	http://repos.lax-noc.com/elrepo/elrepo/el7/$basearch/
	http://mirror.ventraip.net.au/elrepo/elrepo/el7/$basearch/
mirrorlist=http://mirrors.elrepo.org/mirrors-elrepo.el7
enabled=1
gpgcheck=0
protect=0

[elrepo-testing]
name=ELRepo.org Community Enterprise Linux Testing Repository - el7
baseurl=http://elrepo.org/linux/testing/el7/$basearch/
	http://mirrors.coreix.net/elrepo/testing/el7/$basearch/
	http://jur-linux.org/download/elrepo/testing/el7/$basearch/
	http://repos.lax-noc.com/elrepo/testing/el7/$basearch/
	http://mirror.ventraip.net.au/elrepo/testing/el7/$basearch/
mirrorlist=http://mirrors.elrepo.org/mirrors-elrepo-testing.el7
enabled=0
gpgcheck=0
protect=0

[elrepo-kernel]
name=ELRepo.org Community Enterprise Linux Kernel Repository - el7
baseurl=http://elrepo.org/linux/kernel/el7/$basearch/
	http://mirrors.coreix.net/elrepo/kernel/el7/$basearch/
	http://jur-linux.org/download/elrepo/kernel/el7/$basearch/
	http://repos.lax-noc.com/elrepo/kernel/el7/$basearch/
	http://mirror.ventraip.net.au/elrepo/kernel/el7/$basearch/
mirrorlist=http://mirrors.elrepo.org/mirrors-elrepo-kernel.el7
enabled=1
gpgcheck=0
protect=0

[elrepo-extras]
name=ELRepo.org Community Enterprise Linux Extras Repository - el7
baseurl=http://elrepo.org/linux/extras/el7/$basearch/
	http://mirrors.coreix.net/elrepo/extras/el7/$basearch/
	http://jur-linux.org/download/elrepo/extras/el7/$basearch/
	http://repos.lax-noc.com/elrepo/extras/el7/$basearch/
	http://mirror.ventraip.net.au/elrepo/extras/el7/$basearch/
mirrorlist=http://mirrors.elrepo.org/mirrors-elrepo-extras.el7
enabled=1
gpgcheck=0
protect=0
EOF

#echo ">>> Kernel: $(uname -r)"
#echo ">>> Updating system to $CENTOS_VERSION"
#sed -i -e 's/^mirrorlist=/#mirrorlist=/' -e 's/^#baseurl=/baseurl=/' /etc/yum.repos.d/CentOS-Base.repo
#yum -y --releasever=$CENTOS_VERSION update
#sed -i -e 's/^#mirrorlist=/mirrorlist=/' -e 's/^baseurl=/#baseurl=/' /etc/yum.repos.d/CentOS-Base.repo

yum update -y
#yum remove -y kernel-headers kernel-devel
yum install -y kernel-ml kernel-ml-devel kernel-ml-headers
echo ">>> Set kernel parameters for docker"
sed -i /net.ipv4.ip_forward/d /etc/sysctl.conf
cat << 'EOF' > /etc/sysctl.d/10-docker.conf
net.ipv4.ip_forward=1
net.bridge.bridge-nf-call-ip6tables=1
net.bridge.bridge-nf-call-iptables=1
net.bridge.bridge-nf-call-arptables=1
EOF

echo ">>> Set grub2 to use latest kernel"
sed -i s/default=\"1\"/default=\"0\"/ /boot/grub2/grub.cfg
entry=`awk -F\' '/menuentry/ && /elrepo/ {print $2}' /boot/grub2/grub.cfg | head -n1`
grub2-set-default "$entry"

echo ">>> Disabling SELinux"
sed -i 's/SELINUX=.*$/SELINUX=disabled/g' /etc/selinux/config
#setenforce 0

echo ">>> Adjusting SSH Daemon Configuration"

#sed -i '/^\s*PermitRootLogin /d' /etc/ssh/sshd_config
#echo -e "\nPermitRootLogin without-password" >> /etc/ssh/sshd_config

sed -i '/^\s*UseDNS /d' /etc/ssh/sshd_config
echo -e "\nUseDNS no" >> /etc/ssh/sshd_config

echo ">>> Installing DC/OS dependencies and essential packages"
yum -y --tolerant install perl tar xz unzip curl bind-utils net-tools ipset libtool-ltdl rsync nfs-utils

echo ">>> Set up filesystem mounts"
cat << 'EOF' > /etc/systemd/system/dcos_vol_setup.service
[Unit]
Description=Initial setup of volume mounts

[Service]
Type=oneshot
ExecStart=/usr/local/sbin/dcos_vol_setup.sh /dev/xvde /var/lib/mesos
ExecStart=/usr/local/sbin/dcos_vol_setup.sh /dev/xvdf /var/lib/docker
ExecStart=/usr/local/sbin/dcos_vol_setup.sh /dev/xvdg /dcos/volume0
ExecStart=/usr/local/sbin/dcos_vol_setup.sh /dev/xvdh /var/log

[Install]
WantedBy=local-fs.target
EOF
systemctl enable dcos_vol_setup

echo ">>> Disable rsyslog"
systemctl disable rsyslog

echo ">>> Set journald limits"
mkdir -p /etc/systemd/journald.conf.d/
echo -e "[Journal]\nSystemMaxUse=15G" > /etc/systemd/journald.conf.d/dcos-el7-ami.conf

echo ">>> Removing tty requirement for sudo"
sed -i'' -E 's/^(Defaults.*requiretty)/#\1/' /etc/sudoers

echo ">>> Install Docker"
curl -fLsSv --retry 20 -Y 100000 -y 60 -o /tmp/docker-engine-1.13.1-1.el7.centos.x86_64.rpm \
  https://yum.dockerproject.org/repo/main/centos/7/Packages/docker-engine-1.13.1-1.el7.centos.x86_64.rpm
curl -fLsSv --retry 20 -Y 100000 -y 60 -o /tmp/docker-engine-selinux-1.13.1-1.el7.centos.noarch.rpm \
  https://yum.dockerproject.org/repo/main/centos/7/Packages/docker-engine-selinux-1.13.1-1.el7.centos.noarch.rpm
yum -y localinstall /tmp/docker*.rpm || true
echo ">>> Creating docker config"
mkdir -p /etc/docker
cat << 'EOF' > /etc/docker/daemon.json
{ "insecure-registries":["registry.marathon.l4lb.thisdcos.directory:5000", "gitlab.marathon.l4lb.thisdcos.directory:50000"],
  "live-restore": true,
  "storage-driver": "overlay2",
  "storage-opts": ["overlay2.override_kernel_check=true"],
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
yum clean all
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
