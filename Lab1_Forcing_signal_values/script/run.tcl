cd ..
set root_dir [pwd]
cd script
set resultDir ../project

file mkdir $resultDir

create_project project $resultDir -part xc7z010clg400-1
set_property board_part digilentinc.com:zybo-z7-10:part0:1.0 [current_project]


# Design files
add_files -norecurse ../dut/full_adder.vhd

# Update
update_compile_order -fileset sources_1

# Simulation files
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse ../sim/full_adder_tb.vhd

# Update
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
