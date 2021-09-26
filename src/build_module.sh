#!/bin/bash

echo 'SETTING ENV VARIABLES'
source environment_variables.sh
echo 'ENV VARIABLES SET'

mv ${SOURCE_PATH}/config /${KERNEL_PATH}/.config

echo 'BUILDING THE KERNEL'
cd ${KERNEL_PATH} && \
make ARCH=arm CROSS_COMPILE=${COMPILER_PATH}/bin/arm-linux-gnueabihf- oldconfig && \
make ARCH=arm CROSS_COMPILE=${COMPILER_PATH}/bin/arm-linux-gnueabihf-
echo 'KERNEL BUILT'

echo 'BUILDING MODULES'
cd ${SOURCE_PATH} && \
make
echo 'MODULES BUILT'
