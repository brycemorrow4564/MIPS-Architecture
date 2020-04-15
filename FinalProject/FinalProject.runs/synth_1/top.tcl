# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param chipscope.maxJobs 2
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.cache/wt [current_project]
set_property parent.project_path C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/imports/new/display640x480.vh
read_mem {
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/new/imem_screentest.mem
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/new/bmem_screentest.mem
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/new/dmem_screentest.mem
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/new/smem_screentest.mem
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/new/imem_screentest_nopause.mem
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/new/imem_etchasketch.mem
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/new/dmem_etchasketch.mem
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/new/imem_full-IO-test.mem
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/new/dmem_full-IO-test.mem
}
read_verilog -library xil_defaultlib -sv {
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/imports/sources_1/imports/new/ALU.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/imports/sources/accelerometer.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/imports/sources_1/imports/Lab2a.srcs/sources_1/new/adder.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/imports/sources_1/imports/Lab2a.srcs/sources_1/new/addsub.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/imports/COMP541/Lab7/Lab7.srcs/sources_1/new/bitmapmem.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/new/buttonInput.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/new/clockdiv.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/imports/sources_1/imports/Lab2a.srcs/sources_1/new/comparator.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/new/controller.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/new/datamem.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/new/datapath.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/imports/new/debouncer.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/imports/COMP541/Lab5/Lab5.srcs/sources_1/new/display8digit.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/imports/sources_1/imports/Lab2a.srcs/sources_1/imports/new/fulladder.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/imports/new/hexto7seg.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/imports/sources_1/imports/Lab2a.srcs/sim_4/new/logical.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/new/memIO.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/new/mips.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/imports/COMP541/Lab5/Lab5.srcs/sources_1/new/montek_sound_Nexys4.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/imports/sources_1/new/register_file.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/imports/sources_1/new/rom.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/imports/new/screenmem.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/imports/sources_1/imports/Lab2a.srcs/sim_5/new/shifter.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/imports/new/vgadisplaydriver.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/imports/new/vgatimer.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/imports/new/xycounter.sv
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/new/top.sv
}
read_vhdl -library xil_defaultlib {
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/imports/sources/ADXL362Ctrl.vhd
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/imports/sources/AccelArithmetics.vhd
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/imports/sources/AccelerometerCtl.vhd
  C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/sources_1/imports/sources/SPI_If.vhd
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/constrs_1/imports/COMP541/Lab4/Lab4.srcs/constrs_1/new/clock.xdc
set_property used_in_implementation false [get_files C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/constrs_1/imports/COMP541/Lab4/Lab4.srcs/constrs_1/new/clock.xdc]

read_xdc C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/constrs_1/imports/COMP541/Lab4/Lab4.srcs/constrs_1/new/vga.xdc
set_property used_in_implementation false [get_files C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/constrs_1/imports/COMP541/Lab4/Lab4.srcs/constrs_1/new/vga.xdc]

read_xdc C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/constrs_1/imports/COMP541/Lab5/Lab5.srcs/constrs_1/new/accel_DDR.xdc
set_property used_in_implementation false [get_files C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/constrs_1/imports/COMP541/Lab5/Lab5.srcs/constrs_1/new/accel_DDR.xdc]

read_xdc C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/constrs_1/imports/COMP541/Lab5/Lab5.srcs/constrs_1/new/keyboard_DDR.xdc
set_property used_in_implementation false [get_files C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/constrs_1/imports/COMP541/Lab5/Lab5.srcs/constrs_1/new/keyboard_DDR.xdc]

read_xdc C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/constrs_1/imports/COMP541/Lab5/Lab5.srcs/constrs_1/new/led_DDR.xdc
set_property used_in_implementation false [get_files C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/constrs_1/imports/COMP541/Lab5/Lab5.srcs/constrs_1/new/led_DDR.xdc]

read_xdc C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/constrs_1/imports/COMP541/Lab5/Lab5.srcs/constrs_1/new/sound.xdc
set_property used_in_implementation false [get_files C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/constrs_1/imports/COMP541/Lab5/Lab5.srcs/constrs_1/new/sound.xdc]

read_xdc C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/constrs_1/new/reset_DDR.xdc
set_property used_in_implementation false [get_files C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/constrs_1/new/reset_DDR.xdc]

read_xdc C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/constrs_1/imports/new/segdisplay_DDR.xdc
set_property used_in_implementation false [get_files C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/constrs_1/imports/new/segdisplay_DDR.xdc]

read_xdc C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/constrs_1/new/buttons_DDR.xdc
set_property used_in_implementation false [get_files C:/Users/Bryce/Desktop/COMP541/FinalProject/FinalProject.srcs/constrs_1/new/buttons_DDR.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top top -part xc7a100tcsg324-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef top.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]