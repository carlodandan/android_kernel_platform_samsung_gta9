#!/bin/bash

KERNEL_PLATFORM=$(pwd)

sudo apt-get install bison flex rsync device-tree-compiler bc cpio lz4 -y

git clone --depth=1 https://github.com/cdpkp/android_kernel_tree_samsung_gta9 -b android-14 $KERNEL_PLATFORM/kernel-5.10

cd kernel-5.10
python3 scripts/gen_build_config.py --kernel-defconfig gta9_00_defconfig --kernel-defconfig-overlays "entry_level.config ot11.config" -m user -o $KERNEL_PLATFORM/out/target/product/gta9/obj/KERNEL_OBJ/build.config

export ARCH=arm64
export PLATFORM_VERSION=13
export CROSS_COMPILE="aarch64-linux-gnu-"
export CROSS_COMPILE_COMPAT="arm-linux-gnueabi-"
export OUT_DIR="../out/target/product/gta9/obj/KERNEL_OBJ"
export DIST_DIR="../out/target/product/gta9/obj/KERNEL_OBJ"
export BUILD_CONFIG="../out/target/product/gta9/obj/KERNEL_OBJ/build.config"

cd ../kernel
./build/build.sh 
