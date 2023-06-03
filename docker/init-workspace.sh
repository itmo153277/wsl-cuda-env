#!/bin/bash

set -euxo pipefail

cp -Rv /etc/skel/. .
touch .hushlogin
echo "PS1=[cuda]\$PS1" >> .bashrc

python3 -m venv venv --system-site-packages
source venv/bin/activate
pip install --upgrade pip setuptools wheel six
echo "export PATH=/workspace/venv/bin:\$PATH" >> .profile

git clone https://github.com/microsoft/vcpkg --depth 1
./vcpkg/bootstrap-vcpkg.sh --disableMetrics

