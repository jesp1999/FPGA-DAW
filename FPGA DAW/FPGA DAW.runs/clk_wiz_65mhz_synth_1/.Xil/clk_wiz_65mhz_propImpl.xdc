set_property SRC_FILE_INFO {cfile:{g:/My Drive/Coursework/MIT/Fall 2020/6.111/Final Project/FPGA DAW/FPGA DAW.srcs/sources_1/ip/clk_wiz_65mhz/clk_wiz_65mhz.xdc} rfile:{../../../FPGA DAW.srcs/sources_1/ip/clk_wiz_65mhz/clk_wiz_65mhz.xdc} id:1 order:EARLY scoped_inst:inst} [current_design]
current_instance inst
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.1
