module recorder( input clk_in, input rst_in,
                input logic [12:0] notes_in,
                input logic [2:0] octave_in,
                input logic [2:0] instrument_in,
                input record,
                input logic [1:0] track,
                output logic [7:0] beat_count,
                output logic [12:0] notes_out [3:0],
                output logic [2:0] octave_out [3:0],
                output logic [2:0] instrument_out [3:0]
 
);
     parameter METRONOME_MAX = 16250000;
 
     logic [23:0] metronome_ctr = 0;
     logic [7:0] beat_ctr = 0;
 
     logic[19:0] record_out [3:0];
     logic [12:0] record_notes_out [3:0];
     logic [2:0] record_octave_out [3:0];
     logic [2:0] record_instrument_out [3:0];
     genvar i;
     generate
         for (i=0; i<4; i=i+1) begin
            assign record_notes_out[i] = (record && track==i) ? notes_in : record_out[i][12:0];
            assign record_octave_out[i] = (record && track==i) ? octave_in : record_out[i][15:13];
            assign record_instrument_out[i] = (record && track==i) ? instrument_in : record_out[i][17];
         end
     endgenerate
     logic write = 0;
 
     blk_mem_gen_0 rec_0(.addra(beat_ctr), .clka(clk_in), 
              .dina({instrument_in, 1'b0, octave_in, notes_in}), 
              .douta(record_out[0]), .wea(write && track == 0));
              
     blk_mem_gen_0 rec_1(.addra(beat_ctr), .clka(clk_in), 
              .dina({instrument_in, 1'b0, octave_in, notes_in}), 
              .douta(record_out[1]), .wea(write && track == 1));
     
     blk_mem_gen_0 rec_2(.addra(beat_ctr), .clka(clk_in), 
              .dina({instrument_in, 1'b0, octave_in, notes_in}), 
              .douta(record_out[2]), .wea(write && track == 2));
     
     blk_mem_gen_0 rec_3(.addra(beat_ctr), .clka(clk_in), 
              .dina({instrument_in, 1'b0, octave_in, notes_in}), 
              .douta(record_out[3]), .wea(write && track == 3));
 
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
 
     assign notes_out = record_notes_out;
     assign octave_out = record_octave_out;
     assign instrument_out = record_instrument_out;
 
 
endmodule