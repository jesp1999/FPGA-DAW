-makelib xcelium_lib/xpm -sv \
  "D:/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "D:/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../FPGA DAW.srcs/sources_1/ip/clk_wiz_65mhz/clk_wiz_65mhz_clk_wiz.v" \
  "../../../../FPGA DAW.srcs/sources_1/ip/clk_wiz_65mhz/clk_wiz_65mhz.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

