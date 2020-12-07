`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2020 03:30:33 PM
// Design Name: 
// Module Name: recorder_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module recorder_tb;

    logic clk_65mhz, btnc, clean_btnl, clean_btnr;
    logic [12:0] notes;
    logic [2:0] octave, instrument;
    logic [1:0] track;
    logic [12:0] notes_to_play [3:0];
    logic [7:0] beat_count;
    logic [2:0] octave_to_play [3:0];
    logic [2:0] instrument_to_play [3:0];
    logic [7:0] latest_valid_beat [3:0];
    logic metronome;
    

    recorder #(.METRONOME_MAX(400), .METRONOME_INTERVAL_MAX(300), .METRONOME_INTERVAL_MIN(100)) uut (.clk_in(clk_65mhz), .rst_in(btnc), .rst_beat_count(clean_btnl), .rst_track(clean_btnr),
        .notes_in(notes),
        .octave_in(octave),
        .instrument_in(instrument),
        .record(1), // CHANGE LATER
        .track(track),
        .beat_count(beat_count),
        .notes_out(notes_to_play),
        .octave_out(octave_to_play),
        .instrument_out(instrument_to_play),
        .latest_valid_beat(latest_valid_beat),
        .metronome(metronome));


    always #2 clk_65mhz = !clk_65mhz;
    
    initial begin
    
    clk_65mhz=0;
    btnc=0;
    clean_btnl=0;
    clean_btnr=0;
    instrument=0;
    
    #5;
    btnc=1;
    #10;
    btnc=0;
    #10;
    
    end        
 
endmodule
