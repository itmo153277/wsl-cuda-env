#!/bin/bash

set -euxo pipefail

cp -Rv /etc/skel/. .
touch .hushlogin
echo "PS1=[cuda]\$PS1" >> .bashrc

python3 -m venv venv --system-site-packages
source venv/bin/activate
pip install --no-cache --upgrade pip setuptools wheel six
pip install pycuda pylint flake8 autopep8 pydocstyle cpplint
echo "export PATH=/workspace/venv/bin:\$PATH" >> .profile

git clone https://github.com/microsoft/vcpkg --depth 1
./vcpkg/bootstrap-vcpkg.sh --disableMetrics
echo "export VCPKG_FORCE_SYSTEM_BINARIES=1" >> .profile
echo "export VCPKG_OVERLAY_PORTS=/workspace/wsl-cuda-env/vcpkg-overlay-ports" >> .profile
echo "export VCPKG_ROOT=/workspace/vcpkg" >> .profile

mkdir -p ./miniconda3
curl -fsSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh > ./miniconda3/miniconda.sh
bash ./miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm  ./miniconda3/miniconda.sh
