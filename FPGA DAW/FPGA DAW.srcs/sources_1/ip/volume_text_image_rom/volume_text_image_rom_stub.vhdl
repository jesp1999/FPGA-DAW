-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
-- Date        : Sun Dec  6 21:35:16 2020
-- Host        : DESKTOP-5PA8C12 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {G:/My Drive/Coursework/MIT/Fall 2020/6.111/FPGA/FPGA-DAW/FPGA
--               DAW/FPGA DAW.srcs/sources_1/ip/volume_text_image_rom/volume_text_image_rom_stub.vhdl}
-- Design      : volume_text_image_rom
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity volume_text_image_rom is
  Port ( 
    clka : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 8 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );

end volume_text_image_rom;

architecture stub of volume_text_image_rom is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clka,addra[8:0],douta[7:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "blk_mem_gen_v8_4_4,Vivado 2019.2";
begin
end;
