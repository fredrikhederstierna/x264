#!/bin/bash

# Simple script to disassmenle x264 for compilation
# for bare-metal ARM Cortex-M target.
#
# Fredrik Hederstierna 2017

CROSS_TOOLPATH=/usr/local/gcc/arm-none-eabi-toolchain-gcc-6.3.0-hardfloat
PREFIX=$CROSS_TOOLPATH/arm-none-eabi/include
CROSS_PREFIX=$CROSS_TOOLPATH/bin/arm-none-eabi-

"$CROSS_PREFIX"objdump -dath libx264.a > libx264.a.dis
