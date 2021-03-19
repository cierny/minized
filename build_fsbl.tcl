file mkdir output/fsbl
exec cp output/fpga/minized_sbc_base.xsa output/fsbl/hardware_description.xsa

openhw output/fsbl/hardware_description.xsa
hsi create_sw_design -proc ps7_cortexa9_0 -os standalone fsbl

hsi add_library xilffs
hsi add_library xilrsa

hsi generate_app -proc ps7_cortexa9_0 -app zynq_fsbl -dir output/fsbl -compile

hsi close_hw_design [hsi current_hw_design]
