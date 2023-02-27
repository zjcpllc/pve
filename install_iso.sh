#!/bin/bash
#from https://github.com/spiritLHLS/pve


## China_IP
if [[ -z "${CN}" ]]; then
  if [[ $(curl -m 10 -s https://ipapi.co/json | grep 'China') != "" ]]; then
      _yellow "根据ipapi.co提供的信息，当前IP可能在中国"
      read -e -r -p "是否选用中国镜像完成安装? [Y/n] " input
      case $input in
          [yY][eE][sS] | [yY])
              echo "使用中国镜像"
              CN=true
          ;;
          [nN][oO] | [nN])
              echo "不使用中国镜像"
          ;;
          *)
              echo "使用中国镜像"
              CN=true
          ;;
      esac
  fi
fi

echo "请选择要下载到的模板目录："
echo "1. Proxmox VE 的模板目录（/var/lib/vz/template/iso/）"
echo "2. LXC 的模板目录（/var/lib/vz/template/cache/）"
echo "3. 全都要"
read -p "请输入选项编号（1或2）: " choice

# 将镜像文件移动到Proxmox VE的模板目录中
case "$choice" in
  1)
    if [[ -n "${CN}" ]]; then
      wget -P /root/ https://mirrors.tuna.tsinghua.edu.cn/ubuntu-cloud-images/focal/current/focal-server-cloudimg-amd64.img
      wget -P /root/ https://ghproxy.com/https://github.com/spiritLHLS/pve/releases/download/debian-11.6.0-amd64-netinst.iso/debian-11.6.0-amd64-netinst.iso
    else
      wget -P /root/ https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img
      wget -P /root/ https://github.com/spiritLHLS/pve/releases/download/debian-11.6.0-amd64-netinst.iso/debian-11.6.0-amd64-netinst.iso
    fi
    mv /root/focal-server-cloudimg-amd64.img /var/lib/vz/template/iso/
    mv /root/debian-11.6.0-amd64-netinst.iso /var/lib/vz/template/iso/
    echo "已将镜像文件移动到 Proxmox VE 的模板目录"
    ;;
  2)
    if [[ -n "${CN}" ]]; then
      wget -P /root/ https://mirrors.tuna.tsinghua.edu.cn/proxmox/images/system/debian-11-standard_11.3-0_amd64.tar.gz
      wget -P /root/ https://mirrors.tuna.tsinghua.edu.cn/proxmox/images/system/ubuntu-20.10-standard_20.10-1_amd64.tar.gz
#       wget -P /root/ https://mirrors.tuna.tsinghua.edu.cn/proxmox/images/system/debian-10-standard_10.7-1_amd64.tar.gz
    else
      wget -P /root/ http://download.proxmox.com/images/system/ubuntu-20.10-standard_20.10-1_amd64.tar.gz
      wget -P /root/ http://download.proxmox.com/images/system/debian-11-standard_11.3-0_amd64.tar.gz
#       wget -P /root/ http://download.proxmox.com/images/system/debian-10-standard_10.7-1_amd64.tar.gz
    fi
    mv /root/ubuntu-20.10-standard_20.10-1_amd64.tar.gz /var/lib/vz/template/cache/
    mv /root/debian-11-standard_11.3-0_amd64.tar.gz /var/lib/vz/template/cache/
#     mv /root/debian-10-standard_10.7-1_amd64.tar.gz /var/lib/vz/template/cache/
    echo "已将镜像文件移动到 LXC 的模板目录"
    ;;
  3)
    
    if [[ -n "${CN}" ]]; then
      wget -P /root/ https://mirrors.tuna.tsinghua.edu.cn/ubuntu-cloud-images/focal/current/focal-server-cloudimg-amd64.img
      wget -P /root/ https://ghproxy.com/https://github.com/spiritLHLS/pve/releases/download/debian-11.6.0-amd64-netinst.iso/debian-11.6.0-amd64-netinst.iso
      wget -P /root/ https://mirrors.tuna.tsinghua.edu.cn/proxmox/images/system/debian-11-standard_11.3-0_amd64.tar.gz
      wget -P /root/ https://mirrors.tuna.tsinghua.edu.cn/proxmox/images/system/ubuntu-20.10-standard_20.10-1_amd64.tar.gz
#       wget -P /root/ https://mirrors.tuna.tsinghua.edu.cn/proxmox/images/system/debian-10-standard_10.7-1_amd64.tar.gz
    else
      wget -P /root/ https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img
      wget -P /root/ https://github.com/spiritLHLS/pve/releases/download/debian-11.6.0-amd64-netinst.iso/debian-11.6.0-amd64-netinst.iso
      wget -P /root/ http://download.proxmox.com/images/system/ubuntu-20.10-standard_20.10-1_amd64.tar.gz
      wget -P /root/ http://download.proxmox.com/images/system/debian-11-standard_11.3-0_amd64.tar.gz
#       wget -P /root/ http://download.proxmox.com/images/system/debian-10-standard_10.7-1_amd64.tar.gz
    fi
    mv /root/focal-server-cloudimg-amd64.img /var/lib/vz/template/iso/
    mv /root/debian-11.6.0-amd64-netinst.iso /var/lib/vz/template/iso/
    mv /root/ubuntu-20.10-standard_20.10-1_amd64.tar.gz /var/lib/vz/template/cache/
    mv /root/debian-11-standard_11.3-0_amd64.tar.gz /var/lib/vz/template/cache/
#     mv /root/debian-10-standard_10.7-1_amd64.tar.gz /var/lib/vz/template/cache/
    ;;
  *)
    echo "无效的选项，程序退出"
    ;;
esac
