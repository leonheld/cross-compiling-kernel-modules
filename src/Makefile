obj-m := cp210x.o
CROSS_COMPILE := ${COMPILER_PATH}/bin/arm-linux-gnueabihf-
KERNEL := ${KERNEL_PATH}
PWD := $(shell pwd)
default:
	make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) -C $(KERNEL) M=$(PWD) modules
clean:
	make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) -C $(KERNEL) M=$(PWD) clean