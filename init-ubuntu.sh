#!/bin/bash

set -euxo pipefail

# Init distro
rm -f /.dockerenv
export DEBIAN_FRONTEND=noninteractive
export LANGUAGE=
export LC_CTYPE=C.UTF-8
export LC_ALL=C.UTF-8
apt-get -qq update
apt-get -qq -y full-upgrade > /dev/null
apt-get -qq -y install --no-install-recommends sudo curl gnupg2 apt-utils ca-certificates > /dev/null
useradd -m -d /home/username -s /bin/bash ubuntu-cuda
echo "ubuntu-cuda:Passw0rd!" | chpasswd
usermod -aG sudo ubuntu-cuda
cat > /etc/wsl.conf << "EOF"
[user]
default=ubuntu-cuda
EOF

# Install docker + nvidia
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg |\
  gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu focal stable" \
> /etc/apt/sources.list.d/docker.list
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | \
  gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -fsSL https://nvidia.github.io/libnvidia-container/ubuntu20.04/libnvidia-container.list | \
  sed "s#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g" \
> /etc/apt/sources.list.d/nvidia-container-toolkit.list

apt-get -qq update
apt-get -qq -y install --no-install-recommends docker-ce docker-ce-cli containerd.io docker-compose-plugin nvidia-docker2 git > /dev/null
usermod -aG docker ubuntu-cuda
