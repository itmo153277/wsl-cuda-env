FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      curl \
      ca-certificates && \
    curl -sSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" > /etc/apt/sources.list.d/docker.list && \
    curl -sSL https://nvidia.github.io/nvidia-docker/gpgkey | apt-key add - && \
    curl -sSL https://nvidia.github.io/nvidia-docker/ubuntu20.04/nvidia-docker.list > /etc/apt/sources.list.d/nvidia-docker.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      sudo \
      locales \
      bash-completion \
      build-essential \
      cmake \
      git \
      clang-tidy \
      cppcheck \
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
      python3-dev \
      python3-libnvinfer \
      docker-ce \
      nvidia-container-toolkit && \
    rm -rf /var/lib/apt/lists/*

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen

RUN mkdir -p /etc/OpenCL/vendors && \
    echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd
