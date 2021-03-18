set kern_ver {2020.2}
set boot_args {console=ttyPS0,115200 earlyprintk}

hsi set_repo_path device-tree-xlnx

file mkdir output/dtb
exec cp output/fpga/[lindex $argv 0]_[lindex $argv 1].xsa output/dtb/hardware_description.xsa

openhw output/dtb/hardware_description.xsa
hsi create_sw_design device-tree -proc ps7_cortexa9_0 -os device_tree

hsi set_property CONFIG.kernel_version $kern_ver [hsi get_os]
hsi set_property CONFIG.bootargs $boot_args [hsi get_os]
hsi set_property CONFIG.console_device {ps7_uart_1} [hsi get_os]

hsi generate_target -dir output/dtb

hsi close_hw_design [hsi current_hw_design]
