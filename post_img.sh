#!/bin/bash
set -e
cp ../output/fsbl/executable.elf "${BINARIES_DIR}/fsbl.elf"
cp ../output/fpga/image_raw.bit "${BINARIES_DIR}/fpga.bit"
cp ../config/boot.bif "${BINARIES_DIR}"
cd "${BINARIES_DIR}"
../host/bin/arm-buildroot-linux-gnueabihf-objcopy -I binary -B arm -O elf32-littlearm zImage.minized linux.o
../host/bin/arm-buildroot-linux-gnueabihf-ld -e 0x800000 -z max-page-size=0x8000 -o linux.elf --script zynq_linux_boot.lds clearreg.o linux.o
bootgen -w on -image boot.bif -o i boot.bin
rm fpga.bit boot.bif fsbl.elf
echo ${TARGET_CROSS}
