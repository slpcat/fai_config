项目使用pxe自动安装技术进行大规模裸机（物理机与虚拟机）安装部署linux系统。
目标
1.	降低新手门槛，可以从更高的技术平台起步
2.	节约专业人员时间，把时间专注于高水准技术
3.	降低系统基础设施维护和安全防护成本
使用要求：
局域网需要DHCP，安装过程保持网络畅通，否则无法更新，以及部分模板会安装失败。
大规模安装方式： 光盘安装 fai-server作为安装服务器，然后配置pxe服务，配置安装源代理服务，完成后其他主机设置bios 网卡pxe启动从fai-server批量安装系统。
提供可启动光盘ISO镜像，用于单机安装。
当前支持系统及配置模板
 
一．	原版系统 
菜单选项：后缀demo 用户名demo 密码fai 用户名root 密码fai
Dedian 9 原版基本系统
Ubuntu 16.04 原版基本系统
Ubuntu 14.04 原版基本系统

二．	定制系统
菜单选项：pxe前缀与无后缀 用户名hmuserpwd 密码 hmuser 用户名root 密码 rootpwd 系统改动:性能调优，部分配置增强，安全改进,ZFS存储支持
Centos 7 定制基本系统，Docker运行环境,GNOME桌面环境，KDE桌面环境,XFCE桌面环境
Centos 6 定制基本系统
Debian 9 定制基本系统，Docker运行环境,GNOME桌面环境，KDE桌面环境,LXDE桌面环境,MATE桌面环境，XFCE桌面环境
Dedian 8 定制基本系统，Docker运行环境,Mysql服务器，web后端（LNP），web服务器（LNMP）
Ubuntu 18.04 定制基本系统,GNOME桌面环境
Ubuntu 16.04 定制基本系统,Docker运行环境,Unity桌面环境
Ubuntu 14.04 定制基本系统,Docker运行环境,Unity桌面环境
DEEPIN 15.5 深度Linux桌面环境

三．	安全加固系统
在定制系统基础上，启用grsecurity/pax加固内核，初始系统未启用RBAC，仅支持DAC自主访问控制，制作配置RBAC规则后，才能达到最高安全等级（以下第四类）。
菜单选项：grsec 前缀 
用户名hmuser 密码 hmuserpwd 用户名root 密码 rootpwd
Dedian 8 grsecurity安全加固基本系统，Mysql服务器，web后端（LNP），web服务器（LNMP）

四．	安全加固系统 启用RBAC角色访问控制 目标具备实用价值的高级安全系统
在上述grsecurity/pax安全系统基础上，进一步启用RBAC角色访问控制，默认就是最高安全防护级别。
菜单选项RBAC 前缀
 用户名hmuser 密码 hmuserpwd 用户名root 密码 rootpwd
   RBAC访问控制规则密码：rbacpwd
   RBAC管理员角色admin密码：adminpwd
   RBAC管理员角色（仅关闭和重启操作系统）shutdown密码：shutdownpwd
   Dedian 8 grsecurity安全加固基本系统 启用角色访问控制规则，无差别严格管制系统中每个用户每个程序的行为，取消root用户特权，对抗各种未知内存溢出漏洞，对抗root提权，缓解或者消除木马与后门威胁。
支持秘密审计记录系统中用户行为，确保记录机制无法被发现，无法逃脱。
内置RBAC规则集可以用于保卫生产环境安全nginx，apache，php，nfs，openvpn，sshd，rsyslog等。

Debian系列是本系统合集作者生产环境服务器部署的系统，各种先进特性予以优先支持，包括grsecurity内核与RBAC，bcc-tools动态追踪。

详细安装步骤请参考：
https://github.com/slpcat/handbook/blob/master/fai-project%E5%AE%89%E8%A3%85%E6%9C%8D%E5%8A%A1%E5%99%A8%E6%90%AD%E5%BB%BA%E6%8C%87%E5%8D%97.pdf
系统配置优化，软件安装，安全加固等改动请参考：
https://github.com/slpcat/handbook/blob/master/fai-project%E7%B3%BB%E7%BB%9F%E5%AE%89%E8%A3%85%E5%AE%9A%E5%88%B6%E7%AE%80%E4%BB%8B.pdf
