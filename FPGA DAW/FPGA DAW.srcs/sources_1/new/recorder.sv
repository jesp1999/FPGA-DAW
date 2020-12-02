module recorder( input clk_in, input rst_in,
                input logic [12:0] notes_in,
                input logic [3:0] octave_in,
                input instrument_in,
                input record,
                output logic [7:0] beat_count,
                output logic [12:0] notes_out,
                output logic [3:0] octave_out,
                output logic instrument_out
 
);
     parameter METRONOME_MAX = 16250000;
 
     logic [23:0] metronome_ctr = 0;
     logic [7:0] beat_ctr = 0;
 
     logic[19:0] record_out;
     logic [12:0] record_notes_out;
     assign record_notes_out = record_out[12:0];
     logic [3:0] record_octave_out;
     assign record_octave_out = record_out[16:13];
     logic record_instrument_out;
     assign record_instrument_out = record_out[17];
     logic write = 0;
 
     blk_mem_gen_0 rec_bram(.addra(beat_ctr), .clka(clk_in), 
              .dina({2'b00, instrument_in, octave_in, notes_in}), 
              .douta(record_out), .wea(write));  
 
     assign beat_count = beat_ctr;
 
     always_ff @(posedge clk_in) begin
        if (rst_in) begin
            metronome_ctr <= 0;
            beat_ctr <= 0;
        end else if (metronome_ctr == METRONOME_MAX) begin
            metronome_ctr <= 0;
            beat_ctr <= beat_ctr + 1;
            if (record) write <= 1;
        end else begin
            metronome_ctr <= metronome_ctr + 1;
        end
        if (write == 1) write <= 0;
     end
 
     assign notes_out = record ? notes_in : record_notes_out;
     assign octave_out = record ? octave_in : record_octave_out;
     assign instrument_out = record ? instrument_in : record_instrument_out;
 
 
endmodule