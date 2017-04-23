#!/bin/bash

# Simple configure script to setup x264 for compilation
# for bare-metal ARM Cortex-M target.
#
# Fredrik Hederstierna 2017

CROSS_TOOLPATH=/usr/local/gcc/arm-none-eabi-toolchain-gcc-6.3.0-hardfloat
PREFIX=$CROSS_TOOLPATH/arm-none-eabi/include
CROSS_PREFIX=$CROSS_TOOLPATH/bin/arm-none-eabi-

CFLAGS="-fno-common -ffunction-sections -fdata-sections -mcpu=cortex-m4 -march=armv7e-m -mfloat-abi=hard -mfpu=fpv4-sp-d16 -mthumb -Os -I$PREFIX"
LDFLAGS="-mcpu=cortex-m4 -march=armv7e-m -Xlinker --cref -Xlinker --gc-sections"

./configure --host=arm-none --disable-opencl --disable-interlaced --enable-static --disable-cli --prefix=$PREFIX --cross-prefix=$CROSS_PREFIX --extra-cflags="$CFLAGS" --extra-ldflags="$LDFLAGS" --disable-asm --disable-avs --disable-fileio --disable-heap --disable-bss --disable-zones
