FROM nvidia/cuda:13.1.1-cudnn-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i "s@http://archive.ubuntu@http://jp.archive.ubuntu@g" /etc/apt/sources.list && \
    apt-get update && \
    apt-get -y full-upgrade && \
    apt-get install -y --no-install-recommends \
      curl \
      ca-certificates && \
    curl -fsSL https://github.com/Kitware/CMake/releases/download/v4.2.3/cmake-4.2.3-linux-x86_64.tar.gz | tar xzf - -C /usr/local --strip-components 1 --skip-old-files && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu jammy stable" > /etc/apt/sources.list.d/docker.list && \
    curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key | gpg --dearmor -o /etc/apt/keyrings/llvm-snapshot.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/llvm-snapshot.gpg] http://apt.llvm.org/jammy/ llvm-toolchain-jammy-20 main" > /etc/apt/sources.list.d/llvm.list && \
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
      file \
      ninja-build \
      gdb \
      g++-12 \
      clang-20 \
      clang-tidy-20 \
      clang-format-20 \
      cppcheck \
      libgtk-3-dev \
      libcairo2-dev \
      tensorrt-dev \
      nvidia-opencl-dev \
      clinfo \
      python3 \
      python3-venv \
      python3-dev \
      python3-libnvinfer \
      docker-ce-cli \
      docker-buildx-plugin && \
    update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-20 0 && \
    update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-20 0 && \
    rm -rf /var/lib/apt/lists/*

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8

RUN mkdir -p /etc/OpenCL/vendors && \
    echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd
