`timescale 1ns / 1ps


module top_level(
                    input logic ps2_data,
                    input logic ps2_clk,
                    input logic [15:0] sw,
                    input logic clk_100mhz,
                    input logic btnc,
                    input logic btnl,
                    input logic btnu,
                    input logic btnd,
                    output logic [7:0] an,
                    output logic ca,
                    output logic cb,
                    output logic cc,
                    output logic cd,
                    output logic ce,
                    output logic cf,
                    output logic cg);

    input_handler input_handler_mod ();
    waveform_select waveform_sel_mod ();
    mixer mixer_mod ();
    seven_seg_controller seven_seg_mod ();
    effects effects_mod ();
endmodule