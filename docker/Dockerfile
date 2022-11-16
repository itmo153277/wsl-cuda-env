FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      curl \
      ca-certificates \
      build-essential \
      cmake \
      git \
      llvm-dev \
      zlib1g-dev \
      libtinfo-dev \
      libedit-dev \
      libxml2-dev \
      libnvinfer-dev \
      libnvparsers-dev \
      libnvinfer-plugin-dev \
      libnvonnxparsers-dev \
      libnvinfer-bin \
      nvidia-opencl-dev \
      clinfo \
      python3 \
      python3-venv \
      python3-libnvinfer && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/OpenCL/vendors && \
    echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd
