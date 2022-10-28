#!/bin/bash

set -euxo pipefail

# Init distro
rm -f /.dockerenv
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y full-upgrade
apt-get -y install sudo curl gnupg2 apt-utils
useradd -m -d /home/username -s /bin/bash ubuntu-cuda
echo "ubuntu-cuda:Passw0rd!" | chpasswd
usermod -aG sudo ubuntu-cuda
cat > /etc/wsl.conf << "EOF"
[user]
default=ubuntu-cuda
EOF

# Install docker + nvidia
curl -fsSL https://get.docker.com | sh
usermod -aG docker ubuntu-cuda

curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | \
gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg

curl -fsSL https://nvidia.github.io/libnvidia-container/ubuntu20.04/libnvidia-container.list | \
sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

apt-get update
apt-get install -y nvidia-docker2
