#!/bin/bash
set -euxo pipefail

apt update -y
apt install -y \
  wget apt-transport-https gpg \
  lsb-release \
  docker.io

# Adoptium GPG
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public \
| gpg --dearmor -o /usr/share/keyrings/adoptium.gpg

echo "deb [signed-by=/usr/share/keyrings/adoptium.gpg] \
https://packages.adoptium.net/artifactory/deb \
$(lsb_release -cs) main" \
> /etc/apt/sources.list.d/adoptium.list

apt update -y
apt install -y temurin-17-jdk

# Docker
sudo apt-get update
sudo apt-get install docker.io -y
sudo usermod -aG docker ubuntu
sudo usermod -aG docker jenkins  
sudo chmod 777 /var/run/docker.sock
# Wait for docker
until docker info >/dev/null 2>&1; do sleep 3; done

# Add ubuntu user to docker group
usermod -aG docker ubuntu || true

# Swap
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile swap swap defaults 0 0' >> /etc/fstab

# Sysctl for SonarQube
echo "vm.max_map_count=262144" >> /etc/sysctl.conf
echo "fs.file-max=65536" >> /etc/sysctl.conf
sysctl -p

# Run SonarQube
docker run -d \
  --name sonarqube \
  -p 9000:9000 \
  -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true \
  sonarqube:lts-community

echo "USER DATA FINISHED" > /root/userdata_done.txt
