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
     
     assign beat_count = beat_ctr;
     
     always_ff @(posedge clk_in) begin
        if (rst_in) begin
            metronome_ctr <= 0;
            beat_ctr <= 0;
        end else if (metronome_ctr == METRONOME_MAX) begin
            metronome_ctr <= 0;
            beat_ctr <= beat_ctr + 1;
        end else begin
            metronome_ctr <= metronome_ctr + 1;
        end
     end
     
     assign notes_out = notes_in;
     assign octave_out = octave_in;
     assign instrument_out = instrument_in;
     
                
endmodule