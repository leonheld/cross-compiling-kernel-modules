# Cross compiling Kernel Modules in Docker
This repo makes it a little easier to cross-compile kernel modules.
A container description (Dockerfile) is provided and serves as the base for the build. It's based on ubuntu but you can swap for Alpine if you really need to squeeze the mbs.

It also has some helper scripts to start the building process itself. 

It currently uses the Linaro (https://releases.linaro.org/components/toolchain) toolchain for Arm, and can be easily ported for other architectures given the correct toolchain.

## Running
Building and
`docker build --no-cache --target builder -t  kernel-module-cross-compiler .`
`docker run kernel-module-cross-compiler`.

These are the current args you can specify in the build (with `--build-arg [ARG] [OPTION]`):
```
ARG TOOLCHAIN_ROOT  
ARG ROOT_PATH  
ARG KERNEL_VERSION  
ARG CONFIG_PATH  
ARG SRC_PATH
```
I generally exec into it using
`docker run -it kernel-module-cross-compiler -v /src/:/src bash` and create a symbolic link between the folder on the host and the folder on `/src` so every iteration I don't have to rebuild the image.

You can add scp at the bottom of the script, or even use `sshfs` to mount the resulting `.ko` object inside your embedded target.

## Todo
More error handling and conditionals on the bash scripts. 
If you figure a way to easily implement patches on the Kernel, feel free to chip in.
