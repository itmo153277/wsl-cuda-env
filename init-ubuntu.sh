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
useradd -m -d /home/ubuntu-cuda -s /bin/bash ubuntu-cuda
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
curl -fsSL https://nvidia.github.io/nvidia-docker/gpgkey| \
  gpg --dearmor -o /etc/apt/keyrings/nvidia-docker.gpg
curl -fsSL https://nvidia.github.io/nvidia-docker/ubuntu20.04/nvidia-docker.list | \
  sed "s#deb https://#deb [signed-by=/etc/apt/keyrings/nvidia-docker.gpg] https://#g" \
> /etc/apt/sources.list.d/nvidia-docker.list

apt-get -qq update
apt-get -qq -y install --no-install-recommends docker-ce docker-buildx-plugin nvidia-container-toolkit locales tzdata dbus git > /dev/null
usermod -aG docker ubuntu-cuda
