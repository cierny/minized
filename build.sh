#!/bin/bash
# vivado -mode batch -source build_hw_project.tcl -nolog -nojournal -notrace -tclargs minized_sbc base
# xsct -sdx -nodisp build_fsbl.tcl minized_sbc base
# xsct -sdx -nodisp build_dtb.tcl minized_sbc base

# Initialization
SECONDS=0
cores=$(nproc)
cores=$((cores+1))
[ ! -d "output/linux" ] && mkdir -p output/linux
[[ ! -f "buildroot/Makefile" || 
   ! -d "auxiliary/bdf/minized" ||
   ! -d "auxiliary/dts/device_tree" ||
   ! -d "auxiliary/hdl/scripts" ||
   ! -d "auxiliary/meta/recipes-bsp" ]] && git submodule update --init --jobs $cores

# Generate HW project if missing
if [ ! -f "output/fpga/minized_sbc_base.xsa" ]; then
    echo "Generating hardware project..."
    vivado -mode batch -source build_hw_project.tcl -nolog -nojournal -notrace
    echo "Hardware project generated in output/fpga"
else
    # Generate DTS if needed
    dts_gen=true
    if [ -f "output/dts/hardware_description.xsa" ]; then
        if cmp -s -- "output/fpga/minized_sbc_base.xsa" "output/dts/hardware_description.xsa"; then
            dts_gen=false
        fi
    fi
    if [ "$dts_gen" = true ]; then
        echo "Generating DTS..."
        xsct -sdx -nodisp build_dts.tcl
        echo "DTS generated in output/dts"
    fi
fi

# Run buildroot
# cd buildroot
# make defconfig BR2_DEFCONFIG=../config/buildroot.cfg BR2_JLEVEL=$cores O=../output/linux
# cd ../output/linux
# make BR2_JLEVEL=$cores $@

echo "Finished in $((SECONDS/3600))h $(((SECONDS/60)%60))m $((SECONDS%60))s"
