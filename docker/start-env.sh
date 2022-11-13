#!/bin/bash

exec docker run --rm -u $(id -u):$(id -g) --gpus all --net=host -it -v /mnt:/mnt -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro -v $(pwd):/workspace -w /workspace -e HOME=/workspace -e SHELL=bash viktprog/cuda-env
