#!/bin/bash

echo 'SETTING ENV VARIABLES'
source environment_variables.sh
echo 'ENV VARIABLES SET'

echo 'BUILDING THE KERNEL'
cd ${KERNEL_PATH} && make bcm2709_defconfig && \
make ARCH=arm CROSS_COMPILE=${COMPILER_PATH}/bin/arm-linux-gnueabihf-
echo 'KERNEL BUILT'

