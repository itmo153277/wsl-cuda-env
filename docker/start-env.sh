#!/bin/bash

exec docker run \
    --rm \
    --privileged \
    --name cuda-env \
    -u $(id -u):$(id --group) \
    --group-add $(getent group sudo | cut -d: -f3) \
    --group-add $(getent group docker | cut -d: -f3) \
    --gpus all \
    --shm-size=2g \
    --net=host \
    -it \
    -v /mnt:/mnt \
    -v /media:/media \
    -v /etc/passwd:/etc/passwd:ro \
    -v /etc/group:/etc/group:ro \
    -v /etc/shadow:/etc/shadow:ro \
    -v /etc/localtime:/etc/localtime:ro \
    -v /etc/timezone:/etc/timezone:ro \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $(pwd):/workspace \
    -w /workspace \
    -e HOME=/workspace \
    -e SHELL=bash \
    -e TERM \
    -e DISPLAY \
    "$@" \
    viktprog/cuda-env
