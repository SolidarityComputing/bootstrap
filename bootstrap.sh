#! /bin/bash

# insatll Docker
mkdir /home/docker
cd /home/docker
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh --mirror Aliyun
systemctl enable docker
systemctl start docker
echo "Docker OK!"

# update yum
cp /etc/yum.repos.d/CentOS-Base.repo  /etc/yum.repos.d/CentOS-Base.repo.bak
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo
yum clean all
yum makecache
yum -y update
echo "yum OK!"

# install VPN client
systemctl disable firewalld
systemctl stop firewalld
yum -y install ppp pptp pptp-setup
pptpsetup --create myvpn --server your_vpn_server_address  --username your_username --password your_password --encrypt --start
docker swarm leave
docker swarm join --token your_token your_swarm_cluster_address
echo "Complete!!!"
