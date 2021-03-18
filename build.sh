#!/bin/bash
# vivado -mode batch -source build_hw_project.tcl -nolog -nojournal -notrace -tclargs minized_sbc base
# xsct -sdx -nodisp build_fsbl.tcl minized_sbc base
# xsct -sdx -nodisp build_dtb.tcl minized_sbc base

# Initialization
SECONDS=0
cores=$(nproc)
cores=$((cores+1))
[ ! -d "output/br2" ] && mkdir -p output/br2
[ ! -f "buildroot/Makefile" ] && git submodule update --init --jobs $cores

# Run buildroot
cd buildroot
make defconfig BR2_DEFCONFIG=../buildroot.cfg BR2_JLEVEL=$cores O=../output/br2
cd ../output/br2
make BR2_JLEVEL=$cores $@

echo "Finished in $((SECONDS/3600))h $(((SECONDS/60)%60))m $((SECONDS%60))s"
