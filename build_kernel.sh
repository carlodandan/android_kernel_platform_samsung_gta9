#!/bin/bash

sudo apt-get install bison flex rsync device-tree-compiler bc cpio -y

git clone --depth=1 https://github.com/carlodandan/android_kernel_samsung_gta9.git -b master ./kernel-5.10
cd kernel-5.10
python scripts/gen_build_config.py --kernel-defconfig gta9_00_defconfig --kernel-defconfig-overlays "entry_level.config ot11.config" -m user -o ../kernel/build.config

cd ../kernel

export ARCH=arm64
export PLATFORM_VERSION=13
export CROSS_COMPILE="aarch64-linux-gnu-"
export CROSS_COMPILE_COMPAT="arm-linux-gnueabi-"
export OUT_DIR="out"
export DIST_DIR="out"
export BUILD_CONFIG="build.config"
export CLANG_PREBUILT_BIN="kernel/prebuilts-master/clang/host/linux-x86/clang-r416183b/bin"
export LD_LIBRARY_PATH="kernel/prebuilts-master/clang/host/linux-x86/clang-r416183b/lib64"
export LINUX_GCC_CROSS_COMPILE_PREBUILTS_BIN="kernel/prebuilts/gas/linux-x86"

./build/build.sh 
