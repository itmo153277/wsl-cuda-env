#!/bin/bash

set -euxo pipefail

cp -Rv /etc/skel/. .
touch .hushlogin
echo "PS1=[cuda]\$PS1" >> .bashrc

python3 -m venv venv --system-site-packages
source venv/bin/activate
pip install --no-cache --upgrade pip setuptools wheel six
pip install pycuda
echo "export PATH=/workspace/venv/bin:\$PATH" >> .profile

git clone https://github.com/microsoft/vcpkg --depth 1
./vcpkg/bootstrap-vcpkg.sh --disableMetrics
echo "export VCPKG_FORCE_SYSTEM_BINARIES=1" >> .profile
echo "export VCPKG_OVERLAY_PORTS=/workspace/wsl-cuda-env/vcpkg-overlay-ports" >> .profile
echo "export VCPKG_ROOT=/workspace/vcpkg-overlay-ports" >> .profile
