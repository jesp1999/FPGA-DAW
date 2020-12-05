`timescale 1ns / 1ps

module mixer(
             input logic clk_in,
             input logic rst_in,
             input logic [2:0] audio0_vol,
             input logic [2:0] audio1_vol,
             input logic [2:0] audio2_vol,
             input logic [2:0] audio3_vol,
             input logic metronome_enabled,
             input logic [7:0] audio0_in,
             input logic [7:0] audio1_in,
             input logic [7:0] audio2_in,
             input logic [7:0] audio3_in,
             input logic [7:0] metronome_in,
             output logic [7:0] audio_out);
    
    logic [2:0] track_count;
    
    parameter TRACK_MULTIPLER = 2;
    
    logic signed [7:0] audio0_mix_in;
    logic signed [7:0] audio1_mix_in;
    logic signed [7:0] audio2_mix_in;
    logic signed [7:0] audio3_mix_in;
    
    volume_control track0 (.vol_in(audio0_vol), .signal_in(audio0_in), .signal_out(audio0_mix_in));
    volume_control track1 (.vol_in(audio1_vol), .signal_in(audio1_in), .signal_out(audio1_mix_in));
    volume_control track2 (.vol_in(audio2_vol), .signal_in(audio2_in), .signal_out(audio2_mix_in));
    volume_control track3 (.vol_in(audio3_vol), .signal_in(audio3_in), .signal_out(audio3_mix_in));
    
    assign audio_out = 
     (audio0_mix_in>>>TRACK_MULTIPLER) +
     (audio1_mix_in>>>TRACK_MULTIPLER) +
     (audio2_mix_in>>>TRACK_MULTIPLER) +
     (audio3_mix_in>>>TRACK_MULTIPLER); // add metronome
    
endmodule

//Volume Control
module volume_control (input [2:0] vol_in, input signed [7:0] signal_in, output logic signed[7:0] signal_out);
    logic [2:0] shift;
    assign shift = 3'd7 - vol_in;
    assign signal_out = signal_in>>>shift;
endmodule