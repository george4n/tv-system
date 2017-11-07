#!/bin/bash

rm /etc/auto.home

touch /etc/auto.home

echo "#users    -fstype=nfs4,rw,soft,intr,rsize=8192,wsize=8192    172.20.100.11:/media/rdata/home/users
kundservice	-fstype=nfs4,rw,soft,intr,rsize=8192,wsize=8192		172.20.200.100:/media/kundservice
.system   -fstype=nfs4,rw,soft,intr,rsize=8192,wsize=8192         172.20.100.11:/media/rdata/home/users/.system

group1   -fstype=nfs4,rw,soft,intr,rsize=8192,wsize=8192         172.20.10.250:/media/group1
group2   -fstype=nfs4,rw,soft,intr,rsize=8192,wsize=8192         172.20.10.250:/media/group2
group3   -fstype=nfs4,rw,soft,intr,rsize=8192,wsize=8192         172.20.10.250:/media/group3" >> /etc/auto.home

shutdown -r now
