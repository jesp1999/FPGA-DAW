module recorder( input clk_in, input rst_in, input rst_beat_count, input rst_track,
                input logic [12:0] notes_in,
                input logic [2:0] octave_in,
                input logic [2:0] instrument_in,
                input record,
                input logic [1:0] track,
                output logic [7:0] beat_count,
                output logic [12:0] notes_out [3:0],
                output logic [2:0] octave_out [3:0],
                output logic [2:0] instrument_out [3:0],
                output logic [7:0] latest_valid_beat [3:0],
                output logic metronome_main,
                output logic metronome_secondary
 
);
    parameter METRONOME_MAX = 16250000;
    parameter METRONOME_INTERVAL_MAX = 10000000;
    parameter METRONOME_INTERVAL_MIN = 4000000;
    parameter LAST_VALID_BEAT = 255;
   
    logic [23:0] metronome_ctr = 0;
    logic [7:0] beat_ctr = 0;
    
    assign metronome_main = ((metronome_ctr > METRONOME_INTERVAL_MAX) && (beat_ctr[1:0] == 2'b11)) 
        || ((metronome_ctr < METRONOME_INTERVAL_MIN) && (beat_ctr[1:0] == 2'b00));     
    assign metronome_secondary = (metronome_ctr > METRONOME_INTERVAL_MAX) || (metronome_ctr < METRONOME_INTERVAL_MIN);

    logic[19:0] record_out [3:0];
    logic [12:0] record_notes_out [3:0];
    logic [2:0] record_octave_out [3:0];
    logic [2:0] record_instrument_out [3:0];
    genvar i;
    generate
        for (i=0; i<4; i=i+1) begin
           assign record_notes_out[i] = (record && track==i) ? notes_in : ((beat_ctr < latest_valid_beat[i]) ? record_out[i][12:0] : 0);
           assign record_octave_out[i] = (record && track==i) ? octave_in : ((beat_ctr < latest_valid_beat[i]) ? record_out[i][15:13] : 3'b100);
           assign record_instrument_out[i] = (record && track==i) ? instrument_in : ((beat_ctr < latest_valid_beat[i]) ? record_out[i][17] : 0);
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
    
    logic last_rst_track;

    always_ff @(posedge clk_in) begin
       last_rst_track <= rst_track;
       if (rst_in || rst_beat_count) begin
           metronome_ctr <= 0;
           beat_ctr <= 0;
           if (rst_in) begin
               latest_valid_beat[0] <= 0;
               latest_valid_beat[1] <= 0;
               latest_valid_beat[2] <= 0;
               latest_valid_beat[3] <= 0;
           end
       end else if (rst_track == 1 && last_rst_track == 0) begin
           latest_valid_beat[track] <= 0;
       end else if (metronome_ctr == METRONOME_MAX) begin
           metronome_ctr <= 0;
           beat_ctr <= beat_ctr + 1;
           if (record) begin
               write <= 1;
               latest_valid_beat[track] <= (latest_valid_beat[track]==LAST_VALID_BEAT) ? LAST_VALID_BEAT : 
                   ((latest_valid_beat[track] > beat_ctr) ? latest_valid_beat[track] : beat_ctr); // might be off by one...check soon
           end
       end else begin
           metronome_ctr <= metronome_ctr + 1;
       end
       if (write == 1) write <= 0;
    end

    assign notes_out = record_notes_out;
    assign octave_out = record_octave_out;
    assign instrument_out = record_instrument_out;


endmodule