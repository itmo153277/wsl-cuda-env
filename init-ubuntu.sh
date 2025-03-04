#!/bin/bash

set -euxo pipefail

# Init distro
rm -f /.dockerenv
export DEBIAN_FRONTEND=noninteractive
export LANGUAGE=
export LC_CTYPE=C.UTF-8
export LC_ALL=C.UTF-8
sed -i "s@http://archive.ubuntu@http://ja.archive.ubuntu@g" /etc/apt/sources.list
(yes || true) | unminimize
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
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu jammy stable" \
> /etc/apt/sources.list.d/docker.list
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | \
  gpg --dearmor -o /etc/apt/keyrings/nvidia-docker.gpg
curl -fsSL https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
  sed "s#deb https://#deb [signed-by=/etc/apt/keyrings/nvidia-docker.gpg] https://#g" \
> /etc/apt/sources.list.d/nvidia-docker.list

apt-get -qq update
apt-get -qq -y install --no-install-recommends docker-ce docker-buildx-plugin nvidia-container-toolkit locales tzdata dbus git make nano bash-completion > /dev/null
usermod -aG docker ubuntu-cuda

sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen
locale-gen
update-locale LANG=en_US.UTF-8
