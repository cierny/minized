set kern_ver {2020.2}
set boot_args {maxcpus=1 console=ttyPS0,115200 noinitrd earlyprintk clk_ignore_unused root=/dev/mtdblock1 rootfstype=squashfs rootwait}

hsi set_repo_path auxiliary/dts

file mkdir output/dts
exec cp output/fpga/minized_sbc_base.xsa output/dts/hardware_description.xsa

openhw output/dts/hardware_description.xsa
hsi create_sw_design device-tree -proc ps7_cortexa9_0 -os device_tree

hsi set_property CONFIG.kernel_version $kern_ver [hsi get_os]
hsi set_property CONFIG.bootargs $boot_args [hsi get_os]
hsi set_property CONFIG.console_device {ps7_uart_1} [hsi get_os]

hsi generate_target -dir output/dts
hsi close_hw_design [hsi current_hw_design]

exec echo #include \"minized.dtsi\" >> output/dts/system-top.dts
exec mv output/dts/system-top.dts output/dts/minized.dts
