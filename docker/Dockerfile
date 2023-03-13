FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      curl \
      ca-certificates && \
    curl -fsSL https://github.com/Kitware/CMake/releases/download/v3.24.4/cmake-3.24.4-linux-x86_64.tar.gz | tar xzf - -C /usr/local --strip-components 1 --skip-old-files && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" > /etc/apt/sources.list.d/docker.list && \
    curl -fsSL https://nvidia.github.io/nvidia-docker/gpgkey | apt-key add - && \
    curl -fsSL https://nvidia.github.io/nvidia-docker/ubuntu20.04/nvidia-docker.list > /etc/apt/sources.list.d/nvidia-docker.list && \
    curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    echo "deb http://apt.llvm.org/focal/ llvm-toolchain-focal-15 main" > /etc/apt/sources.list.d/llvm.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      sudo \
      locales \
      bash-completion \
      build-essential \
      git \
      ninja-build \
      g++-10 \
      clang-15 \
      clang-tidy-15 \
      llvm-15-dev \
      cppcheck \
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
      docker-buildx-plugin \
      nvidia-container-toolkit && \
    rm -rf /var/lib/apt/lists/*

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen

RUN mkdir -p /etc/OpenCL/vendors && \
    echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd
