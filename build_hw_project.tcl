cd hdl/scripts
set argv [list board=[lindex $argv 0] project=[lindex $argv 1] sdk=no close_project=yes version_override=yes dev_arch=zynq]
set argc [llength $argv]
source ./make.tcl -notrace
file mkdir [file normalize $repo_folder/../output]
file rename ${projects_folder} [file normalize ${repo_folder}/../output/fpga]
