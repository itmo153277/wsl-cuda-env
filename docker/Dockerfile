FROM nvidia/cuda:12.1.1-cudnn8-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      curl \
      ca-certificates && \
    curl -fsSL https://github.com/Kitware/CMake/releases/download/v3.25.1/cmake-3.25.1-linux-x86_64.tar.gz | tar xzf - -C /usr/local --strip-components 1 --skip-old-files && \
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
      autoconf automake m4 bison gettext \
      zip unzip \
      pkg-config \
      git \
      ninja-build \
      gdb \
      g++-10 \
      clang-15 \
      clang-tidy-15 \
      clang-format-15 \
      cppcheck \
      libgtk-3-dev \
      tensorrt-dev \
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
    locale-gen && \
    update-locale LANG=en_US.UTF-8

RUN mkdir -p /etc/OpenCL/vendors && \
    echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd
