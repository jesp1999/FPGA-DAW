`timescale 1ns / 1ps

module mixer(
             input logic clk_in,
             input logic rst_in,
             input logic audio1_enabled,
             input logic audio2_enabled,
             input logic audio3_enabled,
             input logic audio4_enabled,
             input logic metronome_enabled,
             input logic [7:0] audio1_in,
             input logic [7:0] audio2_in,
             input logic [7:0] audio3_in,
             input logic [7:0] audio4_in,
             input logic [7:0] metronome_in,
             output logic [7:0] audio_out);
    
    logic [2:0] track_count;
    
    assign track_count = audio1_enabled +
                         audio2_enabled +
                         audio3_enabled +
                         audio4_enabled +
                         metronome_enabled;
    
    logic [3:0] track_multiplier;
    
    always_comb begin
        if (track_count <= 1) track_multiplier = 4'd1;
        else if (track_count <= 2) track_multiplier = 4'd2;
        else if (track_count <= 4) track_multiplier = 4'd3;
        else track_multiplier = 4'd4;
    end
    
    assign audio_out = 
     (audio1_enabled ? (audio1_in>>track_multiplier) : 0) +
     (audio2_enabled ? (audio2_in>>track_multiplier) : 0) +
     (audio3_enabled ? (audio3_in>>track_multiplier) : 0) +
     (audio4_enabled ? (audio4_in>>track_multiplier) : 0) +
     (metronome_enabled ? (metronome_in>>track_multiplier) : 0);
    
endmodule