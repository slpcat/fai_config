ansible 安装初始化

pip3 install -r requirements.txt

#安装mitogen插件
ansible-playbook -v mitogen.yml

简介

1.基于moosefs社区版，当前仅支持centos6.x 7.x 8.x系列
2.todo master高可用，自愈 drbd84 pacemaker
3.支持master，metalogger，chunkserver，client独立部署。

# run ansbile playbook
ansible-playbook -vv -i moosefs.hosts site.yml
