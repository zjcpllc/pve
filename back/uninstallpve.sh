#!/bin/bash
#from https://github.com/spiritLHLS/pve

for vmid in $(qm list | awk '{if(NR>1) print $1}'); do qm stop $vmid; qm destroy $vmid; rm -rf /var/lib/vz/images/$vmid*; done
iptables -t nat -F
iptables -t filter -F
service networking restart
systemctl restart networking.service
rm -rf vm*
systemctl stop pve-cluster.service
systemctl stop pvedaemon.service
systemctl stop pvestatd.service
systemctl stop pveproxy.service
apt-get remove --purge -y proxmox-ve pve-manager pve-kernel-4.15 pve-kernel-5.11
apt-get remove --purge -y postfix
apt-get remove --purge -y open-iscsi
rm -rf /etc/pve/
rm -rf /var/lib/vz/
rm -rf /var/lib/mysql/
rm -rf /var/log/pve/
rm -rf /var/log/mysql/
rm -rf /var/spool/postfix/
# reboot
