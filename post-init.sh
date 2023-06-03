#!/bin/bash

set -euxo pipefail

mkdir -p ~/workdir
cd ~/workdir

git clone https://github.com/itmo153277/wsl-cuda-env.git --depth 1
ln -sv wsl-cuda-env/docker/start-env.sh
./wsl-cuda-env/docker/build.sh


exec docker run \
    --rm \
    -u $(id -u):$(id --group) \
    -it \
    -v /mnt:/mnt \
    -v /media:/media \
    -v /etc/passwd:/etc/passwd:ro \
    -v /etc/group:/etc/group:ro \
    -v /etc/shadow:/etc/shadow:ro \
    -v /etc/localtime:/etc/localtime:ro \
    -v /etc/timezone:/etc/timezone:ro \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $(pwd):/workspace \
    -w /workspace \
    -e HOME=/workspace \
    -e SHELL=bash \
    -e TERM \
    -e DISPLAY \
    viktprog/cuda-env \
    bash ./wsl-cuda-env/docker/init-workspace.sh

