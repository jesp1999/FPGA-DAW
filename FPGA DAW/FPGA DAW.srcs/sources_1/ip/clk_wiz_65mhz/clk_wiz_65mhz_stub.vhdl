-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
-- Date        : Wed Nov 18 16:27:30 2020
-- Host        : DESKTOP-5PA8C12 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {g:/My Drive/Coursework/MIT/Fall 2020/6.111/Final Project/FPGA
--               DAW/FPGA DAW.srcs/sources_1/ip/clk_wiz_65mhz/clk_wiz_65mhz_stub.vhdl}
-- Design      : clk_wiz_65mhz
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_wiz_65mhz is
  Port ( 
    clk_65mhz : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end clk_wiz_65mhz;

architecture stub of clk_wiz_65mhz is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_65mhz,reset,locked,clk_in1";
begin
end;
