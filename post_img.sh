#!/bin/bash
set -e
cp ../output/fsbl/executable.elf "${BINARIES_DIR}/fsbl.elf"
cp ../output/fsbl/minized_sbc_base.bit "${BINARIES_DIR}/fpga.bit"
cp ../config/boot.bif "${BINARIES_DIR}"
cd "${BINARIES_DIR}"
bootgen -w on -image boot.bif -o i boot.bin
rm fpga.bit boot.bif fsbl.elf
