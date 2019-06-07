Default: pxe-basic-server

Name: Debian 9 Simple demo
Description: My first FAI installation
Short: just a very simple example, no xorg, an account called demo
Long: This is the demohost example of FAI.
Additional account called demo with password: fai, root password: fai
All needed packages are already on the CD or USB stick.
Classes: INSTALL FAIBASE DEBIAN DEMO

Name: Ubuntu 14.04 Simple demo
Description: Ubuntu 14.04 minimal installation
Short: Ubuntu 14.04 minimal installation
Long: We use the Debian nfsroot for installing the Ubuntu OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL FAIBASE DEMO PXETRUSTY TRUSTY TRUSTY64

Name: Ubuntu 16.04 Simple demo
Description: Ubuntu 16.04 minimal installation
Short: Ubuntu 16.04 minimal
Long: We use the Debian nfsroot for installing the Ubuntu OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL FAIBASE DEMO DEBIAN UBUNTU XENIAL XENIAL64

Name: Debian 9 Xfce Desktop
Description: Xfce desktop
Short: A fancy Xfce desktop will be installed, the user account is demo
Long: This is the Xfce desktop example. Additional account called
demo with password: fai, root password: fai
All needed packages are already on the CD or USB stick.
Classes: INSTALL PXEBASE PXEDEBIAN PXEIDC XORG XFCE ZFS

Name: Debian 9 LXDE Desktop
Description: LXDE desktop
Short: A LXDE desktop will be installed, the user account is demo
Long: This is the LXDE desktop example. Additional account called
demo with password: fai, root password: fai
All needed packages are already on the CD or USB stick.
Classes: INSTALL PXEBASE PXEDEBIAN PXEIDC XORG LXDE ZFS

Name: Debian 9 GNOME Desktop
Description: Gnome desktop installation
Short: A Gnome desktop, no LVM, You will get an account called demo
Long: This is the Gnome desktop example. Additional account called
demo with password: fai, root password: fai
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXEDEBIAN PXEIDC XORG GNOME ZFS

Name: Debian 9 KDE Desktop
Description: KDE desktop installation
Short: A KDE desktop, no LVM, You will get an account called demo
Long: This is the KDE desktop example. Additional account called
demo with password: fai, root password: fai
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXEDEBIAN PXEIDC XORG KDE ZFS

Name: Debian 9 MATE Desktop
Description: MATE desktop installation
Short: A MATE desktop, no LVM, You will get an account called demo
Long: This is the MATE desktop example. Additional account called
demo with password: fai, root password: fai
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXEDEBIAN PXEIDC XORG MATE ZFS

Name: DEEPIN 15.10 Desktop
Description: DEEPIN desktop
Short: A fancy DDE desktop will be installed, the user account is hmuser
Long: This is the DDE desktop example. Additional account called
hmuser with password: hmuserpwd, root password: rootpwd
All needed packages are already on the CD or USB stick.
Classes: INSTALL PXEBASE PANDA64 PXEIDC DDE

Name: CentOS 7 GNOME Desktop
Description: CentOS 7 with GNOME desktop
Short: A normal GNOME desktop, running CentOS 7
Long: We use the Debian nfsroot for installing the CentOS 7 OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXECENTOS CENTOS7_64 GNOME_EL7

Name: CentOS 7 KDE Desktop
Description: CentOS 7 with KDE desktop
Short: A normal KDE desktop, running CentOS 7
Long: We use the Debian nfsroot for installing the CentOS 7 OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXECENTOS CENTOS7_64 KDE_EL7

Name: CentOS 7 XFCE Desktop
Description: CentOS 7 with XFCE desktop
Short: A normal XFCE desktop, running CentOS 7
Long: We use the Debian nfsroot for installing the CentOS 7 OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXECENTOS CENTOS7_64 XFCE_EL7

Name: Fedora 27 GNOME Desktop
Description:  Fedora 27 with GNOME desktop
Short: A normal GNOME desktop, running  Fedora 27
Long: We use the Debian nfsroot for installing the  Fedora 27 OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXEFEDORA27 FEDORA27_64 GNOME_FC27

Name: openSUSE 42 KDE Desktop
Description:  openSUSE 42 with KDE desktop
Short: A normal KDE desktop, running openSUSE 42
Long: We use the Debian nfsroot for installing the openSUSE 42 OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXEOPENSUSE42 OPENSUSE_42 KDE_42

Name: Ubuntu 18.04 Desktop
Description: Ubuntu 18.04 desktop installation
Short: Unity desktop
Long: We use the Debian nfsroot for installing the Ubuntu OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXEIDC PXEBIONIC BIONIC64 XORG

Name: Ubuntu 18.04 DDE Desktop
Description: Ubuntu 18.04 with DEEPIN Desktop Environment
Short: DDE desktop
Long: We use the Debian nfsroot for installing the Ubuntu OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXEIDC PXEBIONIC BIONIC64 DDE

Name: Ubuntu 16.04 Desktop
Description: Ubuntu 16.04 desktop installation
Short: Unity desktop
Long: We use the Debian nfsroot for installing the Ubuntu OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXEIDC PXEUBUNTU XENIAL XENIAL64 XORG

Name: Ubuntu 14.04 Desktop
Description: Ubuntu 14.04 desktop installation
Short: Unity desktop
Long: We use the Debian nfsroot for installing the Ubuntu OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXEIDC PXETRUSTY TRUSTY64 XORG

Name: CentOS 7 Docker CUDA noswap
Description: CentOS 7 for docker with CUDA without swap
Short: a very simple server, no xorg
Long: We use the Debian nfsroot for installing the CentOS 7 OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXECENTOS CENTOS7_64 DOCKER CUDA

Name: CentOS 7 Docker noswap
Description: CentOS 7 for docker without swap
Short: a very simple server, no xorg
Long: We use the Debian nfsroot for installing the CentOS 7 OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXECENTOS CENTOS7_64 DOCKER

Name: Ubuntu 18.04 Docker CUDA noswap
Description: Ubuntu 18.04 for docker with CUDA without swap
Short: Ubuntu with minimal install
Long: We use the Debian nfsroot for installing the Ubuntu OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXEIDC PXEBIONIC BIONIC64 DOCKER CUDA

Name: Ubuntu 18.04 Docker noswap
Description: Ubuntu 18.04 for docker without swap
Short: Ubuntu with minimal install
Long: We use the Debian nfsroot for installing the Ubuntu OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXEIDC PXEBIONIC BIONIC64 DOCKER

Name: Ubuntu 16.04 Docker CUDA noswap
Description: Ubuntu 16.04 for docker with CUDA without swap
Short: Ubuntu with minimal install
Long: We use the Debian nfsroot for installing the Ubuntu OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXEIDC PXEUBUNTU XENIAL XENIAL64 DOCKER CUDA

Name: Ubuntu 16.04 Docker noswap
Description: Ubuntu 16.04 for docker without swap
Short: Ubuntu with minimal install
Long: We use the Debian nfsroot for installing the Ubuntu OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXEIDC PXEUBUNTU XENIAL XENIAL64 DOCKER

Name: Ubuntu 14.04 Docker noswap
Description: Ubuntu 14.04 for docker without swap
Short: Ubuntu with minimal install
Long: We use the Debian nfsroot for installing the Ubuntu OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXEIDC PXETRUSTY TRUSTY64 DOCKER

Name: Debian 9 Docker CUDA noswap
Description: debian 9 for docker with CUDA without swap
Short: a very simple server, no xorg
Long: This is the base system .
Additional account called hmuser with password: hmuserpwd
Classes: INSTALL PXEBASE PXEDEBIAN PXEIDC DOCKER ZFS CUDA

Name: Debian 9 Docker noswap
Description: debian 9 for docker without swap
Short: a very simple server, no xorg
Long: This is the base system .
Additional account called hmuser with password: hmuserpwd
Classes: INSTALL PXEBASE PXEDEBIAN PXEIDC DOCKER ZFS

Name: Debian 8 Docker noswap
Description: debian 8 for docker without swap
Short: a very simple server, no xorg
Long: This is the base system .
Additional account called hmuser with password: hmuserpwd
Classes: INSTALL PXEBASE JESSIE64 PXEIDC DOCKER ZFS

Name: Ubuntu 16.04 CDH5 Big Data
Description: Ubuntu 16.04 for CDH5 Big Data
Short: a very simple server, no xorg
Long: We use the Debian nfsroot for installing the Ubuntu 16.04 OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXEIDC PXEUBUNTU XENIAL XENIAL64 CDH5

Name: CentOS 7 CDH5 Big Data
Description: CentOS 7 for CDH5 Big Data
Short: a very simple server, no xorg
Long: We use the Debian nfsroot for installing the CentOS 7 OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXECENTOS CENTOS7_64 CDH5_EL7

Name: Ubuntu 16.04 HDP Big Data
Description: Ubuntu 16.04 for HDP Big Data
Short: a very simple server, no xorg
Long: We use the Debian nfsroot for installing the Ubuntu 16.04 OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXEIDC PXEUBUNTU XENIAL XENIAL64 HDP

Name: CentOS 7 HDP Big Data
Description: CentOS 7 for HDP Big Data
Short: a very simple server, no xorg
Long: We use the Debian nfsroot for installing the CentOS 7 OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXECENTOS CENTOS7_64 HDP_EL7

Name: CentOS 7 Oracle JDK8
Description: CentOS 7 with Oracle JDK8
Short: a very simple server, no xorg
Long: We use the Debian nfsroot for installing the CentOS 7 OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXECENTOS CENTOS7_64 JDK_EL7

Name: pxe-centos-7-basic
Description: CentOS 7 with minimal install
Short: a very simple server, no xorg
Long: We use the Debian nfsroot for installing the CentOS 7 OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXECENTOS CENTOS7_64

Name: pxe-centos-6-basic
Description: CentOS 6 with minimal install
Short: a very simple server, no xorg
Long: We use the Debian nfsroot for installing the CentOS 7 OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXECENTOS6 CENTOS6_64

Name: pxe-fedora-27-basic
Description: Fedora 27 with minimal install
Short: a very simple server, no xorg
Long: We use the Debian nfsroot for installing the Fedora 27 OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXEFEDORA27 FEDORA27_64

Name: pxe-opensuse-42-basic
Description: openSUSE 42 with minimal install
Short: a very simple server, no xorg
Long: We use the Debian nfsroot for installing the openSUSE 42.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXEOPENSUSE42 OPENSUSE_42

Name: pxe-ubuntu-18.04-basic
Description: Ubuntu 18.04 base installation
Short: Ubuntu with minimal install
Long: We use the Debian nfsroot for installing the Ubuntu OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXEIDC PXEBIONIC BIONIC64

Name: pxe-ubuntu-16.04-basic
Description: Ubuntu 16.04 base installation
Short: Ubuntu with minimal install
Long: We use the Debian nfsroot for installing the Ubuntu OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXEIDC PXEUBUNTU XENIAL XENIAL64

Name: pxe-ubuntu-14.04-basic
Description: Ubuntu 14.04 minimal installation
Short: Ubuntu 14.04 minimal installation
Long: We use the Debian nfsroot for installing the Ubuntu OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXEIDC PXETRUSTY TRUSTY TRUSTY64

Name: pxe-basic-server
Description: pxe basic server installation
Short: a very simple server, no xorg
Long: This is the base system .
Additional account called hmuser with password: hmuserpwd
Classes: INSTALL PXEBASE PXEDEBIAN PXEIDC ZFS

Name: pxe-nginx-server-backend
Description: webserver with nginx and php7.1 installation
Short:  nginx php7.1 for web backend
Long: This is the webserver with nginx and php7.1 installation.
Additional account called hmuser with password: hmuserpwd
Classes: INSTALL PXEBASE PXEDEBIAN PXEIDC PXENGINXBACKEND7 ZFS

Name: pxe-mysql-server
Description: MariaDB 10.0 server
Short: This is the mysql server  
Long: This is the mysql server.
Additional account called hmuser with password: hmuserpwd
Classes: INSTALL PXEBASE PXEDEBIAN PXEIDC PXEMYSQL ZFS

Name: pxe-LNMP-webserver
Description: webserver with nginx, mysql and php7.1 installation
Short:  nginx mysql php7.1 webserver
Long: This is the webserver with nginx, mysql and php7.1 installation.
Additional account called hmuser with password: hmuserpwd
Classes: INSTALL PXEBASE PXEDEBIAN PXEIDC PXENGINXBACKEND7 PXEMYSQL ZFS

Name: grsec-basic-server
Description: basic server installation with grsecurity/pax
Short: a very simple server with security , no xorg
Long: This is the base system for highest security.
Additional account called hmuser with password: hmuserpwd
Classes: INSTALL PXEBASE GRSEC JESSIE64 PXEIDC

Name: grsec-nginx-server-backend
Description: webserver with grsecurity/pax nginx and php5 installation
Short:  nginx php5 for web backend for highest security.
Long: This is the webserver with nginx and php5 installation.
Additional account called hmuser with password: hmuserpwd
Classes: INSTALL PXEBASE GRSEC JESSIE64 PXEIDC PXENGINXBACKEND

Name: grsec-mysql-server
Description: MariaDB 10.0 server with grsecurity/pax
Short: This is the mysql server for highest security.
Long: This is the mysql server.
Additional account called hmuser with password: hmuserpwd
Classes: INSTALL PXEBASE GRSEC JESSIE64 PXEIDC PXEMYSQL

Name: grsec-LNMP-webserver
Description: webserver with grsecurity/pax, nginx, mysql and php5 installation
Short:  nginx mysql php5 webserver for highest security.
Long: This is the webserver with nginx, mysql and php5 installation.
Additional account called hmuser with password: hmuserpwd
Classes: INSTALL PXEBASE GRSEC JESSIE64 PXEIDC PXENGINXBACKEND PXEMYSQL

Name: RBAC-basic-server
Description: basic server installation with grsecurity/pax RBAC
Short: a very simple server with RBAC security , no xorg
Long: This is the base system for highest security.
Additional account called hmuser with password: hmuserpwd
Classes: INSTALL PXEBASE GRSEC JESSIE64 PXEIDC GRSEC_RBAC

Name: debian8-basic-server
Description: pxe basic server installation
Short: a very simple server, no xorg
Long: This is the base system .
Additional account called hmuser with password: hmuserpwd
Classes: INSTALL PXEBASE JESSIE64 PXEIDC ZFS

Name: debian8-nginx-server-backend
Description: webserver with nginx and php5 installation
Short:  nginx php5 for web backend
Long: This is the webserver with nginx and php5 installation.
Additional account called hmuser with password: hmuserpwd
Classes: INSTALL PXEBASE JESSIE64 PXEIDC PXENGINXBACKEND ZFS

Name: debian8-mysql-server
Description: MariaDB 10.0 server
Short: This is the mysql server
Long: This is the mysql server.
Additional account called hmuser with password: hmuserpwd
Classes: INSTALL PXEBASE JESSIE64 PXEIDC PXEMYSQL ZFS

Name: debian8-LNMP-webserver
Description: webserver with nginx, mysql and php5 installation
Short:  nginx mysql php5 webserver
Long: This is the webserver with nginx, mysql and php5 installation.
Additional account called hmuser with password: hmuserpwd
Classes: INSTALL PXEBASE JESSIE64 PXEIDC PXENGINXBACKEND PXEMYSQL ZFS

Name: Inventory
Description: Show hardware info
Short: Show some basic hardware infos
Long: Execute commands for showing hardware info
Classes: INVENTORY

Name: Sysinfo
Description: Show defailed system information
Short: Show detailed hardware and system  information
Long: Execute a lot of commands for collecting system information
Classes: SYSINFO
