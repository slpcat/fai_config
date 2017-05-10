Default: pxe-basic-server

Name: Simple
Description: My first FAI installation
Short: just a very simple example, no xorg, an account called demo
Long: This is the demohost example of FAI.
Additional account called demo with password: fai, root password: fai
All needed packages are already on the CD or USB stick.
Classes: INSTALL FAIBASE DEBIAN DEMO

Name: Xfce
Description: Xfce desktop, LVM partitioning
Short: A fancy Xfce desktop will be installed, the user account is demo
Long: This is the Xfce desktop example. Additional account called
demo with password: fai, root password: fai
All needed packages are already on the CD or USB stick.
Classes: INSTALL FAIBASE DEBIAN DEMO XORG XFCE LVM

Name: LXDE
Description: LXDE desktop, LVM partitioning
Short: A LXDE desktop will be installed, the user account is demo
Long: This is the LXDE desktop example. Additional account called
demo with password: fai, root password: fai
All needed packages are already on the CD or USB stick.
Classes: INSTALL FAIBASE DEBIAN DEMO XORG LXDE LVM

Name: Gnome
Description: Gnome desktop installation
Short: A Gnome desktop, no LVM, You will get an account called demo
Long: This is the Gnome desktop example. Additional account called
demo with password: fai, root password: fai
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL FAIBASE DEBIAN DEMO XORG GNOME

Name: KDE
Description: KDE desktop installation
Short: A KDE desktop, no LVM, You will get an account called demo
Long: This is the KDE desktop example. Additional account called
demo with password: fai, root password: fai
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL FAIBASE DEBIAN DEMO XORG KDE

Name: MATE
Description: MATE desktop installation
Short: A MATE desktop, no LVM, You will get an account called demo
Long: This is the MATE desktop example. Additional account called
demo with password: fai, root password: fai
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL FAIBASE DEBIAN DEMO XORG MATE

Name: CentOS 7 GNOME
Description: CentOS 7 with GNOME desktop
Short: A normal GNOME desktop, running CentOS 7
Long: We use the Debian nfsroot for installing the CentOS 7 OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL FAIBASE CENTOS CENTOS7_64 XORG

Name: CentOS 7 KDE
Description: CentOS 7 with KDE desktop
Short: A normal KDE desktop, running CentOS 7
Long: We use the Debian nfsroot for installing the CentOS 7 OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE KDE_EL7 CENTOS7_64 XORG

Name: Ubuntu 16.04
Description: Ubuntu 16.04 desktop installation
Short: Unity desktop
Long: We use the Debian nfsroot for installing the Ubuntu OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL FAIBASE DEMO DEBIAN UBUNTU XENIAL XENIAL64 XORG

Name: ubuntu 14.04 basic
Description: Ubuntu 14.04 minimal installation
Short: Ubuntu 14.04 minimal installation
Long: We use the Debian nfsroot for installing the Ubuntu OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL FAIBASE DEMO PXETRUSTY TRUSTY TRUSTY64

Name: pxe-centos-6-basic
Description: CentOS 6 with minimal install
Short: a very simple server, no xorg
Long: We use the Debian nfsroot for installing the CentOS 7 OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXECENTOS6 CENTOS6_64

Name: pxe-centos-7-basic
Description: CentOS 7 with minimal install
Short: a very simple server, no xorg
Long: We use the Debian nfsroot for installing the CentOS 7 OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXECENTOS CENTOS7_64

Name: pxe-ubuntu-14.04-basic
Description: Ubuntu 14.04 minimal installation
Short: Ubuntu 14.04 minimal installation
Long: We use the Debian nfsroot for installing the Ubuntu OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXEIDC PXETRUSTY TRUSTY TRUSTY64

Name: pxe-ubuntu-16.04-basic
Description: Ubuntu 16.04 base installation
Short: Ubuntu with minimal install
Long: We use the Debian nfsroot for installing the Ubuntu OS.
You should have a fast network connection, because most packages are
downloaded from the internet.
Classes: INSTALL PXEBASE PXEIDC PXEUBUNTU XENIAL XENIAL64

Name: pxe-basic-server
Description: pxe basic server installation
Short: a very simple server, no xorg
Long: This is the base system .
Additional account called hmuser with password: w5podcmtgbhkebiWyc8?Jfziwuvjojgp
Classes: INSTALL PXEBASE PXEDEBIAN PXEIDC

Name: pxe-nginx-server-backend
Description: webserver with nginx and php5 installation
Short:  nginx php5 for web backend
Long: This is the webserver with nginx and php5 installation.
Additional account called hmuser with password: w5podcmtgbhkebiWyc8?Jfziwuvjojgp
Classes: INSTALL PXEBASE PXEDEBIAN PXEIDC PXENGINXBACKEND

Name: pxe-mysql-server
Description: MariaDB 10.0 server
Short: This is the mysql server  
Long: This is the mysql server.
Additional account called hmuser with password: w5podcmtgbhkebiWyc8?Jfziwuvjojgp
Classes: INSTALL PXEBASE PXEDEBIAN PXEIDC PXEMYSQL

Name: pxe-LNMP-webserver
Description: webserver with nginx, mysql and php5 installation
Short:  nginx mysql php5 webserver
Long: This is the webserver with nginx, mysql and php5 installation.
Additional account called hmuser with password: w5podcmtgbhkebiWyc8?Jfziwuvjojgp
Classes: INSTALL PXEBASE PXEDEBIAN PXEIDC PXENGINXBACKEND PXEMYSQL

Name: pxe-gitlab-server
Description: pxe gitlab server installation after reboot
Short: a very simple server, no xorg
Long: This is the base system .
Additional account called hmuser with password: w5podcmtgbhkebiWyc8?Jfziwuvjojgp
Classes: INSTALL PXEBASE PXEDEBIAN PXEIDC PXEGITLAB

Name: grsec-basic-server
Description: basic server installation with grsecurity/pax
Short: a very simple server with security , no xorg
Long: This is the base system for highest security.
Additional account called hmuser with password: w5podcmtgbhkebiWyc8?Jfziwuvjojgp
Classes: INSTALL PXEBASE GRSEC PXEDEBIAN PXEIDC

Name: grsec-nginx-server-backend
Description: webserver with grsecurity/pax nginx and php5 installation
Short:  nginx php5 for web backend for highest security.
Long: This is the webserver with nginx and php5 installation.
Additional account called hmuser with password: w5podcmtgbhkebiWyc8?Jfziwuvjojgp
Classes: INSTALL PXEBASE GRSEC PXEDEBIAN PXEIDC PXENGINXBACKEND

Name: grsec-mysql-server
Description: MariaDB 10.0 server with grsecurity/pax
Short: This is the mysql server for highest security.
Long: This is the mysql server.
Additional account called hmuser with password: w5podcmtgbhkebiWyc8?Jfziwuvjojgp
Classes: INSTALL PXEBASE GRSEC PXEDEBIAN PXEIDC PXEMYSQL

Name: grsec-LNMP-webserver
Description: webserver with grsecurity/pax, nginx, mysql and php5 installation
Short:  nginx mysql php5 webserver for highest security.
Long: This is the webserver with nginx, mysql and php5 installation.
Additional account called hmuser with password: w5podcmtgbhkebiWyc8?Jfziwuvjojgp
Classes: INSTALL PXEBASE GRSEC PXEDEBIAN PXEIDC PXENGINXBACKEND PXEMYSQL

Name: RBAC-basic-server
Description: basic server installation with grsecurity/pax RBAC
Short: a very simple server with RBAC security , no xorg
Long: This is the base system for highest security.
Additional account called hmuser with password: w5podcmtgbhkebiWyc8?Jfziwuvjojgp
Classes: INSTALL PXEBASE GRSEC PXEDEBIAN PXEIDC GRSEC_RBAC

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
