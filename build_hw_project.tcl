cd auxiliary/hdl/scripts
set argv [list board=minized_sbc project=base sdk=no close_project=yes version_override=yes dev_arch=zynq]
set argc [llength $argv]
source ./make.tcl -notrace
file rename ${projects_folder} [file normalize ${repo_folder}/../../output/fpga]
