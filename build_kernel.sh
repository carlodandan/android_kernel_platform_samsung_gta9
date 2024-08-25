#!/bin/bash

sudo apt-get install bison flex rsync device-tree-compiler bc cpio lz4 -y

git clone --depth=1 https://github.com/carlodandan/android_kernel_samsung_gta9.git -b android14 ./kernel-5.10

cd kernel-5.10
python scripts/gen_build_config.py --kernel-defconfig gta9_00_defconfig --kernel-defconfig-overlays "entry_level.config ot11.config" -m user -o ../out/target/product/gta9/obj/KERNEL_OBJ/build.config

export ARCH=arm64
export PLATFORM_VERSION=13
export CROSS_COMPILE="aarch64-linux-gnu-"
export CROSS_COMPILE_COMPAT="arm-linux-gnueabi-"
export OUT_DIR="../out/target/product/gta9/obj/KERNEL_OBJ/build.config"
export DIST_DIR="../out/target/product/gta9/obj/KERNEL_OBJ/build.config"
export BUILD_CONFIG="../out/target/product/gta9/obj/KERNEL_OBJ/build.config"
export CLANG_PREBUILT_BIN="../kernel/prebuilts-master/clang/host/linux-x86/clang-r416183b/bin"
export LD_LIBRARY_PATH="../kernel/prebuilts-master/clang/host/linux-x86/clang-r416183b/lib64"
export LINUX_GCC_CROSS_COMPILE_PREBUILTS_BIN="../kernel/prebuilts/gas/linux-x86"

cd ../kernel
./build/build.sh 
