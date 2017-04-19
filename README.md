# x264
x264 Git mirror - port for bare-metal library build aiming Cortex-M


This is a try to port libx264 to my ARM Cortex-M4 target board.

In addition I have no real RTOS nor Linux on my target, so I needed x264 to work on bare-metal with minimal libc and libm support.

This is what I found out after doing some experimentation.

Problems I needed to solve for bare-metal, was
* My target had no stream IO support, <stdio> FILE etc
* My target had heap memory constraints, no regular HEAP, so <stdlib> malloc/free needed to be customized.
* My target had BSS memory constraints, so I needed to specify large BSS targets to link to external memory.

Maybe some ideas on this fork are useful for someone, also please comment if there are better ways to solve this.
I found a similar approach from the past, though not really formalized into a real patch in
https://github.com/majbthrd/x264stm

To compile code I use this:

#!/bin/bash
CROSS_TOOLPATH=/usr/local/gcc/arm-none-eabi-toolchain-gcc-6.3.0-hardfloat
PREFIX=$CROSS_TOOLPATH/arm-none-eabi/include
CROSS_PREFIX=$CROSS_TOOLPATH/bin/arm-none-eabi-
CFLAGS="-fno-common -ffunction-sections -fdata-sections -mcpu=cortex-m4 -march=armv7e-m -mfloat-abi=hard -mfpu=fpv4-sp-d16 -mthumb -Os -I$PREFIX"
LDFLAGS="-mcpu=cortex-m4 -march=armv7e-m -Xlinker --cref -Xlinker --gc-sections"
./configure --host=arm-none --disable-opencl --disable-interlaced --enable-static --disable-cli --prefix=$PREFIX --cross-prefix=$CROSS_PREFIX --extra-cflags="$CFLAGS" --extra-ldflags="$LDFLAGS" --disable-asm --disable-avs --disable-fileio --disable-heap --disable-bss

My target is real hard bare-metal, no standard C libs at all, not even memcpy, memset etc, I submit all libc fuctions as custom includes.
It seems to work, but I would like some feedback on this approach, also I need to test some more on target.
