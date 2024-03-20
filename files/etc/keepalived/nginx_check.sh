#!/bin/bash
A=` ps -ef|grep nginx|grep -v grep|grep root|grep -v etc|grep -v ingress |wc -l`
if [ $A -eq 0 ];then
    systemctl start nginx.service
sleep 2
if [ `ps -ef|grep nginx|grep -v grep|grep root|grep -v etc|grep -v ingress |wc -l` -eq 0 ];then
	systemctl start keepalived.service
fi
fi
