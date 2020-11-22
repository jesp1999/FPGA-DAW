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
set_param chipscope.maxJobs 4
set_param xicom.use_bs_reader 1
set_msg_config -id {Common 17-41} -limit 10000000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir {G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.cache/wt} [current_project]
set_property parent.project_path {G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.xpr} [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo {g:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files {{G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/coes_1/sqrwave_image.coe}}
add_files {{G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/coes_1/sqrwave_color_map_red.coe}}
add_files {{G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/coes_1/sinewave_image.coe}}
add_files {{G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/coes_1/sinewave_color_map_red.coe}}
add_files {{G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/coes_1/trngwave_image.coe}}
add_files {{G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/coes_1/trngwave_color_map_red.coe}}
read_verilog -library xil_defaultlib -sv {
  {G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/sources_1/new/audio.sv}
  {G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/sources_1/new/binary_to_seven_seg.sv}
  {G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/sources_1/new/debounce.sv}
  {G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/sources_1/new/display.sv}
  {G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/sources_1/new/input_handler.sv}
  {G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/sources_1/new/seven_seg_controller.sv}
  {G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/sources_1/new/waveform_select.sv}
  {G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/sources_1/new/xvga.sv}
  {G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/sources_1/new/top_level.sv}
}
read_ip -quiet {{G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/sources_1/ip/clk_wiz_65mhz/clk_wiz_65mhz.xci}}
set_property used_in_implementation false [get_files -all {{g:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/sources_1/ip/clk_wiz_65mhz/clk_wiz_65mhz_board.xdc}}]
set_property used_in_implementation false [get_files -all {{g:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/sources_1/ip/clk_wiz_65mhz/clk_wiz_65mhz.xdc}}]
set_property used_in_implementation false [get_files -all {{g:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/sources_1/ip/clk_wiz_65mhz/clk_wiz_65mhz_ooc.xdc}}]

read_ip -quiet {{G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/sources_1/ip/sinewave_image_rom/sinewave_image_rom.xci}}
set_property used_in_implementation false [get_files -all {{g:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/sources_1/ip/sinewave_image_rom/sinewave_image_rom_ooc.xdc}}]

read_ip -quiet {{G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/sources_1/ip/sinewave_rcm_rom/sinewave_rcm_rom.xci}}
set_property used_in_implementation false [get_files -all {{g:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/sources_1/ip/sinewave_rcm_rom/sinewave_rcm_rom_ooc.xdc}}]

read_ip -quiet {{G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/sources_1/ip/trngwave_image_rom/trngwave_image_rom.xci}}
set_property used_in_implementation false [get_files -all {{g:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/sources_1/ip/trngwave_image_rom/trngwave_image_rom_ooc.xdc}}]

read_ip -quiet {{G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/sources_1/ip/trngwave_rcm_rom/trngwave_rcm_rom.xci}}
set_property used_in_implementation false [get_files -all {{g:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/sources_1/ip/trngwave_rcm_rom/trngwave_rcm_rom_ooc.xdc}}]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc {{G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/constrs_1/imports/6.111/nexys4_ddr_default.xdc}}
set_property used_in_implementation false [get_files {{G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA-DAW/FPGA DAW/FPGA DAW.srcs/constrs_1/imports/6.111/nexys4_ddr_default.xdc}}]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top top_level -part xc7a100tcsg324-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef top_level.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file top_level_utilization_synth.rpt -pb top_level_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
