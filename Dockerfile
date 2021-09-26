ARG KERNEL_VERSION=5.4.85
ARG ROOT_PATH=/docker-cross-module
ARG TOOLCHAIN_ROOT=${ROOT_PATH}/compiler
ARG CONFIG_PATH=${ROOT_PATH}/config
ARG SRC_PATH=${ROOT_PATH}/src

FROM ubuntu:latest as base
ARG TOOLCHAIN_ROOT
ARG ROOT_PATH
ARG KERNEL_VERSION
ARG CONFIG_PATH
ARG SRC_PATH

RUN apt-get update && apt-get -y upgrade && apt-get -y install \
      git \
      wget \
      xz-utils

WORKDIR ${ROOT_PATH}

# Download Linux Kernel
RUN git clone --depth 1 --branch v${KERNEL_VERSION} https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux.git

# Get the toolchain
RUN wget https://releases.linaro.org/components/toolchain/binaries/7.5-2019.12/arm-linux-gnueabihf/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf.tar.xz
RUN mkdir -p ${TOOLCHAIN_ROOT} && tar xf gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf.tar.xz -C ${TOOLCHAIN_ROOT} --strip-components 1
RUN rm gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf.tar.xz 

# Source code should be on /src on the same folder as the Dockerfile
ADD /src/ ${ROOT_PATH}/src/

# Fresh image bc why not
FROM base AS builder
ARG TOOLCHAIN_ROOT
ARG KERNEL_VERSION
ARG CONFIG_PATH
ARG SRC_PATH


RUN apt-get update && apt-get -y upgrade && apt-get -y install \
      build-essential \
      checkinstall \
      nano \
      bison \
      flex \
      libssl-dev \
      lzop \ 
      bc

ENTRYPOINT ["bash", "build_module.sh"]