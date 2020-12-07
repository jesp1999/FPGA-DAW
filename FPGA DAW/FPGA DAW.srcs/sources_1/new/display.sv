`timescale 1ns / 1ps

module display(
               input logic clk_in,
               input logic rst_in,
               input logic [10:0] hcount_next_in,
               input logic [9:0] vcount_next_in,
               input logic [10:0] hcount_curr_in,
               input logic [9:0] vcount_curr_in,
               input logic [1:0] track,
               input logic [7:0] beat,
               input logic [7:0] latest_valid_beat [3:0],
               input logic [2:0] octave [3:0],
               input logic [2:0] instrument [3:0],
               input logic [2:0] volume [3:0],
               input logic [12:0] keys [3:0],
               output logic [11:0] pixel_out
               );
        
        parameter BACKGROUND_COLOR = 12'hDE3;
        
        ///////////////////////////
        //KEYBOARD//DRAWING//CODE//
        ///////////////////////////
        
        logic [11:0] keyboard_track0_pixel, keyboard_track1_pixel, keyboard_track2_pixel, keyboard_track3_pixel;
        keyboard_blob #(.KEYBOARD_ORIGIN_X(64 + 4), .KEYBOARD_ORIGIN_Y(350))
        blob_keyboard_track0 (.keys(keys[0]), .hcount_in(hcount_curr_in), .vcount_in(vcount_curr_in), .pixel_in(BACKGROUND_COLOR), .pixel_out(keyboard_track0_pixel));
        
        keyboard_blob #(.KEYBOARD_ORIGIN_X(64 + 4 + 222 + 18), .KEYBOARD_ORIGIN_Y(350))
        blob_keyboard_track1 (.keys(keys[1]), .hcount_in(hcount_curr_in), .vcount_in(vcount_curr_in), .pixel_in(BACKGROUND_COLOR), .pixel_out(keyboard_track1_pixel));
        
        keyboard_blob #(.KEYBOARD_ORIGIN_X(64 + 4 + 444 + 36), .KEYBOARD_ORIGIN_Y(350))
        blob_keyboard_track2 (.keys(keys[2]), .hcount_in(hcount_curr_in), .vcount_in(vcount_curr_in), .pixel_in(BACKGROUND_COLOR), .pixel_out(keyboard_track2_pixel));
        
        keyboard_blob #(.KEYBOARD_ORIGIN_X(64 + 4 + 666 + 54), .KEYBOARD_ORIGIN_Y(350))
        blob_keyboard_track3 (.keys(keys[3]), .hcount_in(hcount_curr_in), .vcount_in(vcount_curr_in), .pixel_in(BACKGROUND_COLOR), .pixel_out(keyboard_track3_pixel));
       
       
       
        logic [11:0] config_track0_pixel, config_track1_pixel, config_track2_pixel, config_track3_pixel;
        track_config_blob #(.KEYBOARD_ORIGIN_X(64 + 4), .KEYBOARD_ORIGIN_Y(350))
        blob_config_track0 (.octave(octave[0]), .instrument(instrument[0]), .volume(volume[0]), .hcount_in(hcount_curr_in), .vcount_in(vcount_curr_in), .pixel_in(BACKGROUND_COLOR), .pixel_out(config_track0_pixel));
        
        track_config_blob #(.KEYBOARD_ORIGIN_X(64 + 4 + 222 + 18), .KEYBOARD_ORIGIN_Y(350))
        blob_config_track1 (.octave(octave[1]), .instrument(instrument[1]), .volume(volume[1]), .hcount_in(hcount_curr_in), .vcount_in(vcount_curr_in), .pixel_in(BACKGROUND_COLOR), .pixel_out(config_track1_pixel));
        
        track_config_blob #(.KEYBOARD_ORIGIN_X(64 + 4 + 444 + 36), .KEYBOARD_ORIGIN_Y(350))
        blob_config_track2 (.octave(octave[2]), .instrument(instrument[2]), .volume(volume[2]), .hcount_in(hcount_curr_in), .vcount_in(vcount_curr_in), .pixel_in(BACKGROUND_COLOR), .pixel_out(config_track2_pixel));
        
        track_config_blob #(.KEYBOARD_ORIGIN_X(64 + 4 + 666 + 54), .KEYBOARD_ORIGIN_Y(350))
        blob_config_track3 (.octave(octave[3]), .instrument(instrument[3]), .volume(volume[3]), .hcount_in(hcount_curr_in), .vcount_in(vcount_curr_in), .pixel_in(BACKGROUND_COLOR), .pixel_out(config_track3_pixel));
      
      
      
        logic [11:0] waveform_pixel;
        waveform_blob #(.WAVEFORM_ORIGIN_X(128), .WAVEFORM_ORIGIN_Y(64), .BEAT_BAR_ORIGIN_Y(32), .BEAT_BAR_HEIGHT(244))
        blob_waveform (.clk_in(clk_in), .rst_in(rst_in), .beat(beat), .latest_valid_beat(latest_valid_beat), .notes(keys), .hcount_in(hcount_curr_in), .vcount_in(vcount_curr_in), .pixel_in(BACKGROUND_COLOR), .pixel_out(waveform_pixel));
      
      
      
        logic [11:0] octave_text_pixel, instrument_text_pixel, volume_text_pixel, track0_wfrm_text_pixel, track1_wfrm_text_pixel, track2_wfrm_text_pixel, track3_wfrm_text_pixel, track0_track_text_pixel, track1_track_text_pixel, track2_track_text_pixel, track3_track_text_pixel;
        logic [11:0] track3_track_text_pixel_reg1, track3_track_text_pixel_reg2;
        
        octave_text_blob blob_octave_text (.pixel_clk_in(clk_in), .hcount_in(hcount_next_in), .vcount_in(vcount_next_in), .x_in(2), .y_in(350 + 96 + 32 + 2), .pixel_in(BACKGROUND_COLOR), .pixel_out(octave_text_pixel));

        instrument_text_blob blob_instrument_text (.pixel_clk_in(clk_in), .hcount_in(hcount_next_in), .vcount_in(vcount_next_in), .x_in(2), .y_in(350 + 96 + 64 + 2), .pixel_in(octave_text_pixel), .pixel_out(instrument_text_pixel));

        volume_text_blob blob_volume_text (.pixel_clk_in(clk_in), .hcount_in(hcount_next_in), .vcount_in(vcount_next_in), .x_in(2), .y_in(350 + 96 + 96 + 2), .pixel_in(instrument_text_pixel), .pixel_out(volume_text_pixel));

        track0_text_blob blob_track0_wfrm_text (.pixel_clk_in(clk_in), .hcount_in(hcount_next_in), .vcount_in(vcount_next_in), .select_in(track==2'b00), .x_in(128 - 35 - 16), .y_in(64 + (16 - 8)/2), .pixel_in(volume_text_pixel), .pixel_out(track0_wfrm_text_pixel));

        track1_text_blob blob_track1_wfrm_text (.pixel_clk_in(clk_in), .hcount_in(hcount_next_in), .vcount_in(vcount_next_in), .select_in(track==2'b01), .x_in(128 - 35 - 16), .y_in(64 + 48 + (16 - 8)/2), .pixel_in(track0_wfrm_text_pixel), .pixel_out(track1_wfrm_text_pixel));

        track2_text_blob blob_track2_wfrm_text (.pixel_clk_in(clk_in), .hcount_in(hcount_next_in), .vcount_in(vcount_next_in), .select_in(track==2'b10), .x_in(128 - 35 - 16), .y_in(64 + 96 + (16 - 8)/2), .pixel_in(track1_wfrm_text_pixel), .pixel_out(track2_wfrm_text_pixel));

        track3_text_blob blob_track3_wfrm_text (.pixel_clk_in(clk_in), .hcount_in(hcount_next_in), .vcount_in(vcount_next_in), .select_in(track==2'b11), .x_in(128 - 35 - 16), .y_in(64 + 144 + (16 - 8)/2), .pixel_in(track2_wfrm_text_pixel), .pixel_out(track3_wfrm_text_pixel));

        track0_text_blob blob_track0_track_text (.pixel_clk_in(clk_in), .hcount_in(hcount_next_in), .vcount_in(vcount_next_in), .select_in(track==2'b00), .x_in(64 + 4), .y_in(350 - 9 - 8), .pixel_in(track3_wfrm_text_pixel), .pixel_out(track0_track_text_pixel));

        track1_text_blob blob_track1_track_text (.pixel_clk_in(clk_in), .hcount_in(hcount_next_in), .vcount_in(vcount_next_in), .select_in(track==2'b01), .x_in(64 + 4 + 222 + 18), .y_in(350 - 9 - 8), .pixel_in(track0_track_text_pixel), .pixel_out(track1_track_text_pixel));

        track2_text_blob blob_track2_track_text (.pixel_clk_in(clk_in), .hcount_in(hcount_next_in), .vcount_in(vcount_next_in), .select_in(track==2'b10), .x_in(64 + 4 + 444 + 36), .y_in(350 - 9 - 8), .pixel_in(track1_track_text_pixel), .pixel_out(track2_track_text_pixel));

        track3_text_blob blob_track3_track_text (.pixel_clk_in(clk_in), .hcount_in(hcount_next_in), .vcount_in(vcount_next_in), .select_in(track==2'b11), .x_in(64 + 4 + 666 + 54), .y_in(350 - 9 - 8), .pixel_in(track2_track_text_pixel), .pixel_out(track3_track_text_pixel));
       
        
        always_ff @(posedge clk_in) begin
            if (keyboard_track0_pixel != BACKGROUND_COLOR) begin
                pixel_out <= keyboard_track0_pixel;
            end else if (keyboard_track1_pixel != BACKGROUND_COLOR) begin
                pixel_out <= keyboard_track1_pixel;
            end else if (keyboard_track2_pixel != BACKGROUND_COLOR) begin
                pixel_out <= keyboard_track2_pixel;
            end else if (keyboard_track3_pixel != BACKGROUND_COLOR) begin
                pixel_out <= keyboard_track3_pixel;
            end else if (config_track0_pixel != BACKGROUND_COLOR) begin
                pixel_out <= config_track0_pixel;
            end else if (config_track1_pixel != BACKGROUND_COLOR) begin
                pixel_out <= config_track1_pixel;
            end else if (config_track2_pixel != BACKGROUND_COLOR) begin
                pixel_out <= config_track2_pixel;
            end else if (config_track3_pixel != BACKGROUND_COLOR) begin
                pixel_out <= config_track3_pixel;
            end else if (track3_track_text_pixel_reg2 != BACKGROUND_COLOR) begin
                pixel_out <= track3_track_text_pixel_reg2;
            end else if (waveform_pixel != BACKGROUND_COLOR) begin
                pixel_out <= waveform_pixel;
            end else begin
                pixel_out <= BACKGROUND_COLOR;
            end
            track3_track_text_pixel_reg2 <= track3_track_text_pixel_reg1;
            track3_track_text_pixel_reg1 <= track3_track_text_pixel;
        end
       
endmodule


module waveform_blob
   #(parameter WAVEFORM_ORIGIN_X = 128,
               WAVEFORM_ORIGIN_Y = 64,
               BEAT_BAR_ORIGIN_Y = 32,
               BEAT_BAR_HEIGHT = 244,
               NOTE_WIDTH = 2,
               WAVEFORM_THICKNESS = 16,
               WAVEFORM_SPACING = 32,
               BAR_LINE_THICKNESS = 4,
               BEAT_BAR_COLOR = 12'h333,
               BAR_LINE_COLOR = 12'h666)
   (input logic clk_in,
    input logic rst_in,
    input logic [7:0] beat,
    input logic [7:0] latest_valid_beat [3:0],
    input logic [12:0] notes [3:0],
    input logic [10:0] hcount_in,
    input logic [9:0] vcount_in,
    input logic [11:0] pixel_in,
    output logic [11:0] pixel_out);
    
    logic [7:0] prev_beat;
    logic [2:0] notes_buffer [255:0][3:0];
    logic [7:0] selected_beat;
    logic [11:0] note_colors [3:0];
    logic [3:0] track0_note_sum, track1_note_sum, track2_note_sum, track3_note_sum;
    
    sum13 track0_summer (.bit_vector(notes[0]), .sum(track0_note_sum));
    sum13 track1_summer (.bit_vector(notes[1]), .sum(track1_note_sum));
    sum13 track2_summer (.bit_vector(notes[2]), .sum(track2_note_sum));
    sum13 track3_summer (.bit_vector(notes[3]), .sum(track3_note_sum));
    
    assign selected_beat = {hcount_in - WAVEFORM_ORIGIN_X}[8:1];
            
            
    logic [11:0] barline_track0_pixel, barline_track1_pixel, barline_track2_pixel, barline_track3_pixel;
    rectangle_blob  #(.WIDTH(256*NOTE_WIDTH), .HEIGHT(BAR_LINE_THICKNESS), .COLOR(BAR_LINE_COLOR))
    track0_bar_line (.x_in(WAVEFORM_ORIGIN_X), .y_in(WAVEFORM_ORIGIN_Y + (WAVEFORM_THICKNESS - BAR_LINE_THICKNESS)/2), .hcount_in(hcount_in), .vcount_in(vcount_in), .pixel_in(pixel_in), .pixel_out(barline_track0_pixel));
    
    rectangle_blob  #(.WIDTH(256*NOTE_WIDTH), .HEIGHT(BAR_LINE_THICKNESS), .COLOR(BAR_LINE_COLOR))
    track1_bar_line (.x_in(WAVEFORM_ORIGIN_X), .y_in(WAVEFORM_ORIGIN_Y + WAVEFORM_SPACING + (3*WAVEFORM_THICKNESS - BAR_LINE_THICKNESS)/2), .hcount_in(hcount_in), .vcount_in(vcount_in), .pixel_in(barline_track0_pixel), .pixel_out(barline_track1_pixel));
    
    rectangle_blob  #(.WIDTH(256*NOTE_WIDTH), .HEIGHT(BAR_LINE_THICKNESS), .COLOR(BAR_LINE_COLOR))
    track2_bar_line (.x_in(WAVEFORM_ORIGIN_X), .y_in(WAVEFORM_ORIGIN_Y + 2*WAVEFORM_SPACING + (5*WAVEFORM_THICKNESS - BAR_LINE_THICKNESS)/2), .hcount_in(hcount_in), .vcount_in(vcount_in), .pixel_in(barline_track1_pixel), .pixel_out(barline_track2_pixel));
    
    rectangle_blob  #(.WIDTH(256*NOTE_WIDTH), .HEIGHT(BAR_LINE_THICKNESS), .COLOR(BAR_LINE_COLOR))
    track3_bar_line (.x_in(WAVEFORM_ORIGIN_X), .y_in(WAVEFORM_ORIGIN_Y + 3*WAVEFORM_SPACING + (7*WAVEFORM_THICKNESS - BAR_LINE_THICKNESS)/2), .hcount_in(hcount_in), .vcount_in(vcount_in), .pixel_in(barline_track2_pixel), .pixel_out(barline_track3_pixel));
    
    
    logic [2:0] selector_in_track0, selector_in_track1, selector_in_track2, selector_in_track3;
    assign selector_in_track0 = (selected_beat <= latest_valid_beat[0]) ? notes_buffer[selected_beat][0] : 3'b0;
    assign selector_in_track1 = (selected_beat <= latest_valid_beat[1]) ? notes_buffer[selected_beat][1] : 3'b0;
    assign selector_in_track2 = (selected_beat <= latest_valid_beat[2]) ? notes_buffer[selected_beat][2] : 3'b0;
    assign selector_in_track3 = (selected_beat <= latest_valid_beat[3]) ? notes_buffer[selected_beat][3] : 3'b0;
    
    color_picker track0_color (.selector_in(selector_in_track0), .background_pixel_in(barline_track3_pixel), .color_out(note_colors[0]));
    color_picker track1_color (.selector_in(selector_in_track1), .background_pixel_in(barline_track3_pixel), .color_out(note_colors[1]));
    color_picker track2_color (.selector_in(selector_in_track2), .background_pixel_in(barline_track3_pixel), .color_out(note_colors[2]));
    color_picker track3_color (.selector_in(selector_in_track3), .background_pixel_in(barline_track3_pixel), .color_out(note_colors[3]));
    
    
    always_ff @(posedge clk_in) begin
        if (rst_in) begin
           for (integer i = 0; i < 256; i = i + 1) begin
                for (integer j = 0; j < 4; j = j + 1) begin
                    notes_buffer[i][j] <= 3'b0;
                end
            end
            prev_beat <= 8'b0;
        end else begin
            
            if (beat != prev_beat) begin
                notes_buffer[beat][0] <= track0_note_sum[2:0];
                notes_buffer[beat][1] <= track1_note_sum[2:0];
                notes_buffer[beat][2] <= track2_note_sum[2:0];
                notes_buffer[beat][3] <= track3_note_sum[2:0];
            end
            
            if (vcount_in >= BEAT_BAR_ORIGIN_Y && vcount_in < (BEAT_BAR_ORIGIN_Y + BEAT_BAR_HEIGHT) &&
                hcount_in == WAVEFORM_ORIGIN_X + (beat << 1)) begin
                //vertical bar at note
                pixel_out <= BEAT_BAR_COLOR;
            end else if (hcount_in >= WAVEFORM_ORIGIN_X && hcount_in < WAVEFORM_ORIGIN_X + 256*NOTE_WIDTH) begin
                if (vcount_in >= (WAVEFORM_ORIGIN_Y) && vcount_in < (WAVEFORM_ORIGIN_Y + WAVEFORM_THICKNESS)) begin
                    //track 0 beat
                    pixel_out <= note_colors[0];
                end else if (vcount_in >= (WAVEFORM_ORIGIN_Y + WAVEFORM_THICKNESS + WAVEFORM_SPACING) && vcount_in < (WAVEFORM_ORIGIN_Y + 2*WAVEFORM_THICKNESS + WAVEFORM_SPACING)) begin
                    //track 1 beat
                    pixel_out <= note_colors[1];
                end else if (vcount_in >= (WAVEFORM_ORIGIN_Y + 2*WAVEFORM_THICKNESS + 2*WAVEFORM_SPACING) && vcount_in < (WAVEFORM_ORIGIN_Y + 3*WAVEFORM_THICKNESS + 2*WAVEFORM_SPACING)) begin
                    //track 2 beat
                    pixel_out <= note_colors[2];
                end else if (vcount_in >= (WAVEFORM_ORIGIN_Y + 3*WAVEFORM_THICKNESS + 3*WAVEFORM_SPACING) && vcount_in < (WAVEFORM_ORIGIN_Y + 4*WAVEFORM_THICKNESS + 3*WAVEFORM_SPACING)) begin
                    //track 3 beat
                    pixel_out <= note_colors[3];
                end else begin
                    pixel_out <= barline_track3_pixel;
                end
            end else begin
                pixel_out <= barline_track3_pixel;
            end
            prev_beat <= beat;
        end
    end
endmodule


module color_picker (input logic [2:0] selector_in,
                     input logic [11:0] background_pixel_in,
                     output logic [11:0] color_out);
    always_comb begin
        case(selector_in)
        3'b000: color_out = background_pixel_in;
        3'b001: color_out = 12'h00F;
        3'b010: color_out = 12'h7EF;
        3'b011: color_out = 12'h0F0;
        3'b100: color_out = 12'hFF0;
        3'b101: color_out = 12'hF70;
        3'b110: color_out = 12'hF00;
        3'b111: color_out = 12'hD43;
        default: color_out = background_pixel_in;
        endcase
    end
endmodule


module keyboard_blob
   #(parameter KEYBOARD_ORIGIN_X = 0,
               KEYBOARD_ORIGIN_Y = 0,
               WHITE_KEY_WIDTH = 26,
               WHITE_KEY_HEIGHT = 96,
               BLACK_KEY_WIDTH = 14,
               BLACK_KEY_HEIGHT = 64,
               KEY_SPACING = 2,
               WHITE_KEY_COLOR = 12'hFFF,
               BLACK_KEY_COLOR = 12'h000,
               WHITE_SELECTED_COLOR = 12'hF00,
               BLACK_SELECTED_COLOR = 12'h00F)
   (input logic [12:0] keys,
    input logic [10:0] hcount_in,
    input logic [9:0] vcount_in,
    input logic [11:0] pixel_in,
    output logic [11:0] pixel_out);
   
    localparam BLACK_KEY_OFFSET = 3 * (WHITE_KEY_WIDTH + KEY_SPACING) / 4;
    
    
        logic [11:0] CPix, CSharpPix, DPix, DSharpPix, EPix, FPix, FSharpPix, GPix, GSharpPix, APix, ASharpPix, BPix;
        logic [11:0] sine_img_pixel, sine_icon_pixel, trng_img_pixel, trng_icon_pixel;
         
        selectable_blob  #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT), .COLOR(WHITE_KEY_COLOR), .SELECTED_COLOR(WHITE_SELECTED_COLOR))
        blob_C (.x_in(KEYBOARD_ORIGIN_X), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[12]), .pixel_in(pixel_in), .pixel_out(CPix));
        
        selectable_blob  #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT), .COLOR(WHITE_KEY_COLOR), .SELECTED_COLOR(WHITE_SELECTED_COLOR))
        blob_D (.x_in(KEYBOARD_ORIGIN_X + (WHITE_KEY_WIDTH + KEY_SPACING)), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[10]), .pixel_in(CPix), .pixel_out(DPix));
        
        selectable_blob #(.WIDTH(BLACK_KEY_WIDTH), .HEIGHT(BLACK_KEY_HEIGHT), .COLOR(BLACK_KEY_COLOR), .SELECTED_COLOR(BLACK_SELECTED_COLOR))
        blob_CSharp (.x_in(KEYBOARD_ORIGIN_X + BLACK_KEY_OFFSET), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[11]), .pixel_in(DPix), .pixel_out(CSharpPix));
         
        selectable_blob  #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT), .COLOR(WHITE_KEY_COLOR), .SELECTED_COLOR(WHITE_SELECTED_COLOR))
        blob_E (.x_in(KEYBOARD_ORIGIN_X + 2*(WHITE_KEY_WIDTH + KEY_SPACING)), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[8]), .pixel_in(CSharpPix), .pixel_out(EPix));
         
        selectable_blob #(.WIDTH(BLACK_KEY_WIDTH), .HEIGHT(BLACK_KEY_HEIGHT), .COLOR(BLACK_KEY_COLOR), .SELECTED_COLOR(BLACK_SELECTED_COLOR))
        blob_DSharp (.x_in(KEYBOARD_ORIGIN_X + (WHITE_KEY_WIDTH + KEY_SPACING) + BLACK_KEY_OFFSET), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[9]), .pixel_in(EPix), .pixel_out(DSharpPix));
       
        selectable_blob  #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT), .COLOR(WHITE_KEY_COLOR), .SELECTED_COLOR(WHITE_SELECTED_COLOR))
        blob_F (.x_in(KEYBOARD_ORIGIN_X + 3*(WHITE_KEY_WIDTH + KEY_SPACING)), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[7]), .pixel_in(DSharpPix), .pixel_out(FPix));
       
        selectable_blob  #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT), .COLOR(WHITE_KEY_COLOR), .SELECTED_COLOR(WHITE_SELECTED_COLOR))
        blob_G (.x_in(KEYBOARD_ORIGIN_X + 4*(WHITE_KEY_WIDTH + KEY_SPACING)), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[5]), .pixel_in(FPix), .pixel_out(GPix));
       
        selectable_blob #(.WIDTH(BLACK_KEY_WIDTH), .HEIGHT(BLACK_KEY_HEIGHT), .COLOR(BLACK_KEY_COLOR), .SELECTED_COLOR(BLACK_SELECTED_COLOR))
        blob_FSharp (.x_in(KEYBOARD_ORIGIN_X + 3*(WHITE_KEY_WIDTH + KEY_SPACING) + BLACK_KEY_OFFSET), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[6]), .pixel_in(GPix), .pixel_out(FSharpPix));
       
        selectable_blob  #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT), .COLOR(WHITE_KEY_COLOR), .SELECTED_COLOR(WHITE_SELECTED_COLOR))
        blob_A (.x_in(KEYBOARD_ORIGIN_X + 5*(WHITE_KEY_WIDTH + KEY_SPACING)), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[3]), .pixel_in(FSharpPix), .pixel_out(APix));
       
        selectable_blob #(.WIDTH(BLACK_KEY_WIDTH), .HEIGHT(BLACK_KEY_HEIGHT), .COLOR(BLACK_KEY_COLOR), .SELECTED_COLOR(BLACK_SELECTED_COLOR))
        blob_GSharp (.x_in(KEYBOARD_ORIGIN_X + 4*(WHITE_KEY_WIDTH + KEY_SPACING) + BLACK_KEY_OFFSET), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[4]), .pixel_in(APix), .pixel_out(GSharpPix));
       
        selectable_blob  #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT), .COLOR(WHITE_KEY_COLOR), .SELECTED_COLOR(WHITE_SELECTED_COLOR))
        blob_B (.x_in(KEYBOARD_ORIGIN_X + 6*(WHITE_KEY_WIDTH + KEY_SPACING)), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[1]), .pixel_in(GSharpPix), .pixel_out(BPix));
       
        selectable_blob #(.WIDTH(BLACK_KEY_WIDTH), .HEIGHT(BLACK_KEY_HEIGHT), .COLOR(BLACK_KEY_COLOR), .SELECTED_COLOR(BLACK_SELECTED_COLOR))
        blob_ASharp (.x_in(KEYBOARD_ORIGIN_X + 5*(WHITE_KEY_WIDTH + KEY_SPACING) + BLACK_KEY_OFFSET), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[2]), .pixel_in(BPix), .pixel_out(ASharpPix));
       
        selectable_blob  #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT), .COLOR(WHITE_KEY_COLOR), .SELECTED_COLOR(WHITE_SELECTED_COLOR))
        blob_C2 (.x_in(KEYBOARD_ORIGIN_X + 7*(WHITE_KEY_WIDTH + KEY_SPACING)), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[0]), .pixel_in(ASharpPix), .pixel_out(pixel_out));
        
        
endmodule
   
   
module track_config_blob
   #(parameter KEYBOARD_ORIGIN_X = 0,
               KEYBOARD_ORIGIN_Y = 0,
               WHITE_KEY_WIDTH = 26,
               WHITE_KEY_HEIGHT = 96,
               KEY_SPACING = 2,
               ICON_WIDTH = 16,
               ICON_HEIGHT = 16,
               ICON_SPACING = 16,
               OCTAVE_SELECTED_COLOR = 12'h00F,
               OCTAVE_DESELECTED_COLOR = 12'hBBB,
               INSTRUMENT_SELECTED_COLOR = 12'h0F0,
               INSTRUMENT_DESELECTED_COLOR = 12'hBBB,
               VOLUME_SELECTED_COLOR = 12'hF00,
               VOLUME_DESELECTED_COLOR = 12'hBBB,
               TEXT_DISPLAY = 1'b0)
   (input logic [2:0] octave,
    input logic [2:0] instrument,
    input logic [2:0] volume,
    input logic [10:0] hcount_in,
    input logic [9:0] vcount_in,
    input logic [11:0] pixel_in,
    output logic [11:0] pixel_out);
   
    localparam BLACK_KEY_OFFSET = 3 * (WHITE_KEY_WIDTH + KEY_SPACING) / 4;
    
    
        logic [11:0] octave_0_pix, octave_1_pix, octave_2_pix, octave_3_pix, octave_4_pix, octave_5_pix, octave_6_pix, octave_7_pix;
        logic [11:0] inst_0_pix, inst_1_pix, inst_2_pix, inst_3_pix, inst_4_pix, inst_5_pix, inst_6_pix, inst_7_pix;
        logic [11:0] vol_0_pix, vol_1_pix, vol_2_pix, vol_3_pix, vol_4_pix, vol_5_pix, vol_6_pix, vol_7_pix;
        
        selectable_blob  #(.WIDTH(ICON_WIDTH), .HEIGHT(ICON_HEIGHT), .COLOR(OCTAVE_DESELECTED_COLOR), .SELECTED_COLOR(OCTAVE_SELECTED_COLOR))
        blob_8ve_0 (.x_in(KEYBOARD_ORIGIN_X + (WHITE_KEY_WIDTH - ICON_WIDTH)/2), .y_in(KEYBOARD_ORIGIN_Y + WHITE_KEY_HEIGHT + 32), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(octave==3'b000), .pixel_in(pixel_in), .pixel_out(octave_0_pix));
        
        selectable_blob  #(.WIDTH(ICON_WIDTH), .HEIGHT(ICON_HEIGHT), .COLOR(OCTAVE_DESELECTED_COLOR), .SELECTED_COLOR(OCTAVE_SELECTED_COLOR))
        blob_8ve_1 (.x_in(KEYBOARD_ORIGIN_X + (3*WHITE_KEY_WIDTH + 2*KEY_SPACING - ICON_WIDTH)/2), .y_in(KEYBOARD_ORIGIN_Y + WHITE_KEY_HEIGHT + 32), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(octave==3'b001), .pixel_in(octave_0_pix), .pixel_out(octave_1_pix));
        
        selectable_blob  #(.WIDTH(ICON_WIDTH), .HEIGHT(ICON_HEIGHT), .COLOR(OCTAVE_DESELECTED_COLOR), .SELECTED_COLOR(OCTAVE_SELECTED_COLOR))
        blob_8ve_2 (.x_in(KEYBOARD_ORIGIN_X + (5*WHITE_KEY_WIDTH + 4*KEY_SPACING - ICON_WIDTH)/2), .y_in(KEYBOARD_ORIGIN_Y + WHITE_KEY_HEIGHT + 32), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(octave==3'b010), .pixel_in(octave_1_pix), .pixel_out(octave_2_pix));
         
        selectable_blob  #(.WIDTH(ICON_WIDTH), .HEIGHT(ICON_HEIGHT), .COLOR(OCTAVE_DESELECTED_COLOR), .SELECTED_COLOR(OCTAVE_SELECTED_COLOR))
        blob_8ve_3 (.x_in(KEYBOARD_ORIGIN_X + (7*WHITE_KEY_WIDTH + 6*KEY_SPACING - ICON_WIDTH)/2), .y_in(KEYBOARD_ORIGIN_Y + WHITE_KEY_HEIGHT + 32), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(octave==3'b011), .pixel_in(octave_2_pix), .pixel_out(octave_3_pix));
       
        selectable_blob  #(.WIDTH(ICON_WIDTH), .HEIGHT(ICON_HEIGHT), .COLOR(OCTAVE_DESELECTED_COLOR), .SELECTED_COLOR(OCTAVE_SELECTED_COLOR))
        blob_8ve_4 (.x_in(KEYBOARD_ORIGIN_X + (9*WHITE_KEY_WIDTH + 8*KEY_SPACING - ICON_WIDTH)/2), .y_in(KEYBOARD_ORIGIN_Y + WHITE_KEY_HEIGHT + 32), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(octave==3'b100), .pixel_in(octave_3_pix), .pixel_out(octave_4_pix));
       
        selectable_blob  #(.WIDTH(ICON_WIDTH), .HEIGHT(ICON_HEIGHT), .COLOR(OCTAVE_DESELECTED_COLOR), .SELECTED_COLOR(OCTAVE_SELECTED_COLOR))
        blob_8ve_5 (.x_in(KEYBOARD_ORIGIN_X + (11*WHITE_KEY_WIDTH + 10*KEY_SPACING - ICON_WIDTH)/2), .y_in(KEYBOARD_ORIGIN_Y + WHITE_KEY_HEIGHT + 32), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(octave==3'b101), .pixel_in(octave_4_pix), .pixel_out(octave_5_pix));
       
        selectable_blob  #(.WIDTH(ICON_WIDTH), .HEIGHT(ICON_HEIGHT), .COLOR(OCTAVE_DESELECTED_COLOR), .SELECTED_COLOR(OCTAVE_SELECTED_COLOR))
        blob_8ve_6 (.x_in(KEYBOARD_ORIGIN_X + (13*WHITE_KEY_WIDTH + 12*KEY_SPACING - ICON_WIDTH)/2), .y_in(KEYBOARD_ORIGIN_Y + WHITE_KEY_HEIGHT + 32), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(octave==3'b110), .pixel_in(octave_5_pix), .pixel_out(octave_6_pix));
       
        selectable_blob  #(.WIDTH(ICON_WIDTH), .HEIGHT(ICON_HEIGHT), .COLOR(OCTAVE_DESELECTED_COLOR), .SELECTED_COLOR(OCTAVE_SELECTED_COLOR))
        blob_8ve_7 (.x_in(KEYBOARD_ORIGIN_X + (15*WHITE_KEY_WIDTH + 14*KEY_SPACING - ICON_WIDTH)/2), .y_in(KEYBOARD_ORIGIN_Y + WHITE_KEY_HEIGHT + 32), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(octave==3'b111), .pixel_in(octave_6_pix), .pixel_out(octave_7_pix));
        
        
        selectable_blob  #(.WIDTH(ICON_WIDTH), .HEIGHT(ICON_HEIGHT), .COLOR(INSTRUMENT_DESELECTED_COLOR), .SELECTED_COLOR(INSTRUMENT_SELECTED_COLOR))
        blob_inst_0 (.x_in(KEYBOARD_ORIGIN_X + (WHITE_KEY_WIDTH - ICON_WIDTH)/2), .y_in(KEYBOARD_ORIGIN_Y + WHITE_KEY_HEIGHT + 32 + ICON_SPACING + ICON_HEIGHT), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(instrument==3'b000), .pixel_in(octave_7_pix), .pixel_out(inst_0_pix));
        
        selectable_blob  #(.WIDTH(ICON_WIDTH), .HEIGHT(ICON_HEIGHT), .COLOR(INSTRUMENT_DESELECTED_COLOR), .SELECTED_COLOR(INSTRUMENT_SELECTED_COLOR))
        blob_inst_1 (.x_in(KEYBOARD_ORIGIN_X + (3*WHITE_KEY_WIDTH + 2*KEY_SPACING - ICON_WIDTH)/2), .y_in(KEYBOARD_ORIGIN_Y + WHITE_KEY_HEIGHT + 32 + ICON_SPACING + ICON_HEIGHT), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(instrument==3'b001), .pixel_in(inst_0_pix), .pixel_out(inst_1_pix));
        
        selectable_blob  #(.WIDTH(ICON_WIDTH), .HEIGHT(ICON_HEIGHT), .COLOR(INSTRUMENT_DESELECTED_COLOR), .SELECTED_COLOR(INSTRUMENT_SELECTED_COLOR))
        blob_inst_2 (.x_in(KEYBOARD_ORIGIN_X + (5*WHITE_KEY_WIDTH + 4*KEY_SPACING - ICON_WIDTH)/2), .y_in(KEYBOARD_ORIGIN_Y + WHITE_KEY_HEIGHT + 32 + ICON_SPACING + ICON_HEIGHT), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(instrument==3'b010), .pixel_in(inst_1_pix), .pixel_out(inst_2_pix));
         
        selectable_blob  #(.WIDTH(ICON_WIDTH), .HEIGHT(ICON_HEIGHT), .COLOR(INSTRUMENT_DESELECTED_COLOR), .SELECTED_COLOR(INSTRUMENT_SELECTED_COLOR))
        blob_inst_3 (.x_in(KEYBOARD_ORIGIN_X + (7*WHITE_KEY_WIDTH + 6*KEY_SPACING - ICON_WIDTH)/2), .y_in(KEYBOARD_ORIGIN_Y + WHITE_KEY_HEIGHT + 32 + ICON_SPACING + ICON_HEIGHT), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(instrument==3'b011), .pixel_in(inst_2_pix), .pixel_out(inst_3_pix));
       
        selectable_blob  #(.WIDTH(ICON_WIDTH), .HEIGHT(ICON_HEIGHT), .COLOR(INSTRUMENT_DESELECTED_COLOR), .SELECTED_COLOR(INSTRUMENT_SELECTED_COLOR))
        blob_inst_4 (.x_in(KEYBOARD_ORIGIN_X + (9*WHITE_KEY_WIDTH + 8*KEY_SPACING - ICON_WIDTH)/2), .y_in(KEYBOARD_ORIGIN_Y + WHITE_KEY_HEIGHT + 32 + ICON_SPACING + ICON_HEIGHT), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(instrument==3'b100), .pixel_in(inst_3_pix), .pixel_out(inst_4_pix));
       
        selectable_blob  #(.WIDTH(ICON_WIDTH), .HEIGHT(ICON_HEIGHT), .COLOR(INSTRUMENT_DESELECTED_COLOR), .SELECTED_COLOR(INSTRUMENT_SELECTED_COLOR))
        blob_inst_5 (.x_in(KEYBOARD_ORIGIN_X + (11*WHITE_KEY_WIDTH + 10*KEY_SPACING - ICON_WIDTH)/2), .y_in(KEYBOARD_ORIGIN_Y + WHITE_KEY_HEIGHT + 32 + ICON_SPACING + ICON_HEIGHT), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(instrument==3'b101), .pixel_in(inst_4_pix), .pixel_out(inst_5_pix));
       
        selectable_blob  #(.WIDTH(ICON_WIDTH), .HEIGHT(ICON_HEIGHT), .COLOR(INSTRUMENT_DESELECTED_COLOR), .SELECTED_COLOR(INSTRUMENT_SELECTED_COLOR))
        blob_inst_6 (.x_in(KEYBOARD_ORIGIN_X + (13*WHITE_KEY_WIDTH + 12*KEY_SPACING - ICON_WIDTH)/2), .y_in(KEYBOARD_ORIGIN_Y + WHITE_KEY_HEIGHT + 32 + ICON_SPACING + ICON_HEIGHT), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(instrument==3'b110), .pixel_in(inst_5_pix), .pixel_out(inst_6_pix));
       
        selectable_blob  #(.WIDTH(ICON_WIDTH), .HEIGHT(ICON_HEIGHT), .COLOR(INSTRUMENT_DESELECTED_COLOR), .SELECTED_COLOR(INSTRUMENT_SELECTED_COLOR))
        blob_inst_7 (.x_in(KEYBOARD_ORIGIN_X + (15*WHITE_KEY_WIDTH + 14*KEY_SPACING - ICON_WIDTH)/2), .y_in(KEYBOARD_ORIGIN_Y + WHITE_KEY_HEIGHT + 32 + ICON_SPACING + ICON_HEIGHT), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(instrument==3'b111), .pixel_in(inst_6_pix), .pixel_out(inst_7_pix));
        
        
        selectable_blob  #(.WIDTH(ICON_WIDTH), .HEIGHT(ICON_HEIGHT), .COLOR(VOLUME_DESELECTED_COLOR), .SELECTED_COLOR(VOLUME_SELECTED_COLOR))
        blob_vol_0 (.x_in(KEYBOARD_ORIGIN_X + (WHITE_KEY_WIDTH - ICON_WIDTH)/2), .y_in(KEYBOARD_ORIGIN_Y + WHITE_KEY_HEIGHT + 32 + 2*ICON_SPACING + 2*ICON_HEIGHT), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(volume==3'b000), .pixel_in(inst_7_pix), .pixel_out(vol_0_pix));
        
        selectable_blob  #(.WIDTH(ICON_WIDTH), .HEIGHT(ICON_HEIGHT), .COLOR(VOLUME_DESELECTED_COLOR), .SELECTED_COLOR(VOLUME_SELECTED_COLOR))
        blob_vol_1 (.x_in(KEYBOARD_ORIGIN_X + (3*WHITE_KEY_WIDTH + 2*KEY_SPACING - ICON_WIDTH)/2), .y_in(KEYBOARD_ORIGIN_Y + WHITE_KEY_HEIGHT + 32 + 2*ICON_SPACING + 2*ICON_HEIGHT), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(volume==3'b001), .pixel_in(vol_0_pix), .pixel_out(vol_1_pix));
        
        selectable_blob  #(.WIDTH(ICON_WIDTH), .HEIGHT(ICON_HEIGHT), .COLOR(VOLUME_DESELECTED_COLOR), .SELECTED_COLOR(VOLUME_SELECTED_COLOR))
        blob_vol_2 (.x_in(KEYBOARD_ORIGIN_X + (5*WHITE_KEY_WIDTH + 4*KEY_SPACING - ICON_WIDTH)/2), .y_in(KEYBOARD_ORIGIN_Y + WHITE_KEY_HEIGHT + 32 + 2*ICON_SPACING + 2*ICON_HEIGHT), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(volume==3'b010), .pixel_in(vol_1_pix), .pixel_out(vol_2_pix));
         
        selectable_blob  #(.WIDTH(ICON_WIDTH), .HEIGHT(ICON_HEIGHT), .COLOR(VOLUME_DESELECTED_COLOR), .SELECTED_COLOR(VOLUME_SELECTED_COLOR))
        blob_vol_3 (.x_in(KEYBOARD_ORIGIN_X + (7*WHITE_KEY_WIDTH + 6*KEY_SPACING - ICON_WIDTH)/2), .y_in(KEYBOARD_ORIGIN_Y + WHITE_KEY_HEIGHT + 32 + 2*ICON_SPACING + 2*ICON_HEIGHT), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(volume==3'b011), .pixel_in(vol_2_pix), .pixel_out(vol_3_pix));
       
        selectable_blob  #(.WIDTH(ICON_WIDTH), .HEIGHT(ICON_HEIGHT), .COLOR(VOLUME_DESELECTED_COLOR), .SELECTED_COLOR(VOLUME_SELECTED_COLOR))
        blob_vol_4 (.x_in(KEYBOARD_ORIGIN_X + (9*WHITE_KEY_WIDTH + 8*KEY_SPACING - ICON_WIDTH)/2), .y_in(KEYBOARD_ORIGIN_Y + WHITE_KEY_HEIGHT + 32 + 2*ICON_SPACING + 2*ICON_HEIGHT), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(volume==3'b100), .pixel_in(vol_3_pix), .pixel_out(vol_4_pix));
       
        selectable_blob  #(.WIDTH(ICON_WIDTH), .HEIGHT(ICON_HEIGHT), .COLOR(VOLUME_DESELECTED_COLOR), .SELECTED_COLOR(VOLUME_SELECTED_COLOR))
        blob_vol_5 (.x_in(KEYBOARD_ORIGIN_X + (11*WHITE_KEY_WIDTH + 10*KEY_SPACING - ICON_WIDTH)/2), .y_in(KEYBOARD_ORIGIN_Y + WHITE_KEY_HEIGHT + 32 + 2*ICON_SPACING + 2*ICON_HEIGHT), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(volume==3'b101), .pixel_in(vol_4_pix), .pixel_out(vol_5_pix));
       
        selectable_blob  #(.WIDTH(ICON_WIDTH), .HEIGHT(ICON_HEIGHT), .COLOR(VOLUME_DESELECTED_COLOR), .SELECTED_COLOR(VOLUME_SELECTED_COLOR))
        blob_vol_6 (.x_in(KEYBOARD_ORIGIN_X + (13*WHITE_KEY_WIDTH + 12*KEY_SPACING - ICON_WIDTH)/2), .y_in(KEYBOARD_ORIGIN_Y + WHITE_KEY_HEIGHT + 32 + 2*ICON_SPACING + 2*ICON_HEIGHT), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(volume==3'b110), .pixel_in(vol_5_pix), .pixel_out(vol_6_pix));
       
        selectable_blob  #(.WIDTH(ICON_WIDTH), .HEIGHT(ICON_HEIGHT), .COLOR(VOLUME_DESELECTED_COLOR), .SELECTED_COLOR(VOLUME_SELECTED_COLOR))
        blob_vol_7 (.x_in(KEYBOARD_ORIGIN_X + (15*WHITE_KEY_WIDTH + 14*KEY_SPACING - ICON_WIDTH)/2), .y_in(KEYBOARD_ORIGIN_Y + WHITE_KEY_HEIGHT + 32 + 2*ICON_SPACING + 2*ICON_HEIGHT), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(volume==3'b111), .pixel_in(vol_6_pix), .pixel_out(vol_7_pix));
        
        assign pixel_out = vol_7_pix;
        
endmodule

module rectangle_blob
   #(parameter WIDTH = 64,               // default width: 64 pixels
               HEIGHT = 64,              // default height: 64 pixels
               COLOR = 12'hFFF)          // default color: white)
   (input [10:0] x_in,hcount_in,
    input [9:0] y_in,vcount_in,
    input logic [11:0] pixel_in,
    output logic [11:0] pixel_out);

    always_comb begin
        if  ((hcount_in >= x_in && hcount_in < (x_in+WIDTH)) &&
            (vcount_in >= y_in && vcount_in < (y_in+HEIGHT)))
            pixel_out = COLOR;
        else 
            pixel_out = pixel_in;
    end
endmodule

module selectable_blob
   #(parameter WIDTH = 64,               // default width: 64 pixels
               HEIGHT = 64,              // default height: 64 pixels
               COLOR = 12'hFFF,          // default color: white
               SELECTED_COLOR = 12'hF00) // default color: red
   (input [10:0] x_in,hcount_in,
    input [9:0] y_in,vcount_in,
    input selection,
    input logic [11:0] pixel_in,
    output logic [11:0] pixel_out);

    always_comb begin
        if  ((hcount_in >= x_in && hcount_in < (x_in+WIDTH)) &&
            (vcount_in >= y_in && vcount_in < (y_in+HEIGHT))) begin
            if (selection) begin
                pixel_out = SELECTED_COLOR;
            end else begin
                pixel_out = COLOR;
            end
        end else 
            pixel_out = pixel_in;
    end
endmodule

module octave_text_blob
   #(parameter WIDTH = 35,     // default picture width
               HEIGHT = 9)    // default picture height)
   (input logic pixel_clk_in,
    input logic [10:0] x_in, hcount_in,
    input logic [9:0] y_in, vcount_in,
    input logic [11:0] pixel_in,
    output logic [11:0] pixel_out);

    logic [8:0] image_addr;   // num of bits for 32x32 ROM
    logic [7:0] image_bits, mapped;
    logic [3:0] pix_color;
    
    logic [11:0] pix_reg1, pix_reg2;
    
    // calculate rom address and read the location
    assign image_addr = (hcount_in-x_in) + (vcount_in-y_in) * WIDTH;
    octave_text_image_rom  rom(.clka(pixel_clk_in), .addra(image_addr), .douta(image_bits));
    
    assign pix_color = (image_bits == 8'h00) ? 8'hFF : 8'h00;
    
    always_comb begin
        if ((hcount_in >= (x_in+2) && hcount_in < (x_in+WIDTH+2)) &&
            (vcount_in >= (y_in) && vcount_in < (y_in+HEIGHT)))
            pixel_out = {pix_color, pix_color, pix_color};
        else pixel_out = pixel_in;
    end
endmodule

module instrument_text_blob
   #(parameter WIDTH = 55,     // default picture width
               HEIGHT = 9)    // default picture height)
   (input logic pixel_clk_in,
    input logic [10:0] x_in, hcount_in,
    input logic [9:0] y_in, vcount_in,
    input logic [11:0] pixel_in,
    output logic [11:0] pixel_out);

    logic [9:0] image_addr;   // num of bits for 32x32 ROM
    logic [7:0] image_bits, mapped;
    logic [3:0] pix_color;
    
    // calculate rom address and read the location
    assign image_addr = (hcount_in-x_in) + (vcount_in-y_in) * WIDTH;
    instrument_text_image_rom  rom(.clka(pixel_clk_in), .addra(image_addr), .douta(image_bits));
    
    assign pix_color = (image_bits == 8'h00) ? 8'hFF : 8'h00;
    
    always_comb begin
        if ((hcount_in >= (x_in+2) && hcount_in < (x_in+WIDTH+2)) &&
            (vcount_in >= (y_in) && vcount_in < (y_in+HEIGHT)))
            pixel_out = {pix_color, pix_color, pix_color};
        else pixel_out = pixel_in;
    end
endmodule

module volume_text_blob
   #(parameter WIDTH = 35,     // default picture width
               HEIGHT = 9)    // default picture height)
   (input logic pixel_clk_in,
    input logic [10:0] x_in, hcount_in,
    input logic [9:0] y_in, vcount_in,
    input logic [11:0] pixel_in,
    output logic [11:0] pixel_out);

    logic [8:0] image_addr;   // num of bits for 32x32 ROM
    logic [7:0] image_bits, mapped;
    logic [3:0] pix_color;
    
    // calculate rom address and read the location
    assign image_addr = (hcount_in-x_in) + (vcount_in-y_in) * WIDTH;
    volume_text_image_rom  rom(.clka(pixel_clk_in), .addra(image_addr), .douta(image_bits));
    
    assign pix_color = (image_bits == 8'h00) ? 8'hFF : 8'h00;
    
    always_comb begin
        if ((hcount_in >= (x_in+2) && hcount_in < (x_in+WIDTH+2)) &&
            (vcount_in >= (y_in) && vcount_in < (y_in+HEIGHT)))
            pixel_out = {pix_color, pix_color, pix_color};
        else pixel_out = pixel_in;
    end
endmodule

module track0_text_blob
   #(parameter WIDTH = 35,     // default picture width
               HEIGHT = 9,
               SELECTED_COLOR = 12'hFFF)    // default picture height)
   (input logic pixel_clk_in,
    input logic [10:0] x_in, hcount_in,
    input logic [9:0] y_in, vcount_in,
    input logic select_in,
    input logic [11:0] pixel_in,
    output logic [11:0] pixel_out);

    logic [8:0] image_addr;   // num of bits for 32x32 ROM
    logic [7:0] image_bits, mapped;
    logic [11:0] pix_color;
    
    // calculate rom address and read the location
    assign image_addr = (hcount_in-x_in) + (vcount_in-y_in) * WIDTH;
    track0_text_image_rom  rom(.clka(pixel_clk_in), .addra(image_addr), .douta(image_bits));
    
    assign pix_color = (image_bits == 8'h00) ? 12'hFFF : (select_in ? 12'hF00 : 12'h000);
    
    always_comb begin
        if ((hcount_in >= (x_in+2) && hcount_in < (x_in+WIDTH+2)) &&
            (vcount_in >= (y_in) && vcount_in < (y_in+HEIGHT)))
            pixel_out = pix_color;
        else pixel_out = pixel_in;
    end
endmodule

module track1_text_blob
   #(parameter WIDTH = 35,     // default picture width
               HEIGHT = 9,
               SELECTED_COLOR = 12'hFFF)    // default picture height)
   (input logic pixel_clk_in,
    input logic [10:0] x_in, hcount_in,
    input logic [9:0] y_in, vcount_in,
    input logic select_in,
    input logic [11:0] pixel_in,
    output logic [11:0] pixel_out);

    logic [8:0] image_addr;   // num of bits for 32x32 ROM
    logic [7:0] image_bits, mapped;
    logic [11:0] pix_color;
    
    // calculate rom address and read the location
    assign image_addr = (hcount_in-x_in) + (vcount_in-y_in) * WIDTH;
    track1_text_image_rom  rom(.clka(pixel_clk_in), .addra(image_addr), .douta(image_bits));
    
    assign pix_color = (image_bits == 8'h00) ? 12'hFFF : (select_in ? 12'hF00 : 12'h000);
    
    always_comb begin
        if ((hcount_in >= (x_in+2) && hcount_in < (x_in+WIDTH+2)) &&
            (vcount_in >= (y_in) && vcount_in < (y_in+HEIGHT)))
            pixel_out = pix_color;
        else pixel_out = pixel_in;
    end
endmodule

module track2_text_blob
   #(parameter WIDTH = 35,     // default picture width
               HEIGHT = 9,
               SELECTED_COLOR = 12'hFFF)    // default picture height)
   (input logic pixel_clk_in,
    input logic [10:0] x_in, hcount_in,
    input logic [9:0] y_in, vcount_in,
    input logic select_in,
    input logic [11:0] pixel_in,
    output logic [11:0] pixel_out);

    logic [8:0] image_addr;   // num of bits for 32x32 ROM
    logic [7:0] image_bits, mapped;
    logic [11:0] pix_color;
    
    // calculate rom address and read the location
    assign image_addr = (hcount_in-x_in) + (vcount_in-y_in) * WIDTH;
    track2_text_image_rom  rom(.clka(pixel_clk_in), .addra(image_addr), .douta(image_bits));
    
    assign pix_color = (image_bits == 8'h00) ? 12'hFFF : (select_in ? 12'hF00 : 12'h000);
    
    always_comb begin
        if ((hcount_in >= (x_in+2) && hcount_in < (x_in+WIDTH+2)) &&
            (vcount_in >= (y_in) && vcount_in < (y_in+HEIGHT)))
            pixel_out = pix_color;
        else pixel_out = pixel_in;
    end
endmodule

module track3_text_blob
   #(parameter WIDTH = 35,     // default picture width
               HEIGHT = 9,
               SELECTED_COLOR = 12'hFFF)    // default picture height)
   (input logic pixel_clk_in,
    input logic [10:0] x_in, hcount_in,
    input logic [9:0] y_in, vcount_in,
    input logic select_in,
    input logic [11:0] pixel_in,
    output logic [11:0] pixel_out);

    logic [8:0] image_addr;   // num of bits for 32x32 ROM
    logic [7:0] image_bits, mapped;
    logic [11:0] pix_color;
    
    // calculate rom address and read the location
    assign image_addr = (hcount_in-x_in) + (vcount_in-y_in) * WIDTH;
    track3_text_image_rom  rom(.clka(pixel_clk_in), .addra(image_addr), .douta(image_bits));
    
    assign pix_color = (image_bits == 8'h00) ? 12'hFFF : (select_in ? 12'hF00 : 12'h000);
    
    always_comb begin
        if ((hcount_in >= (x_in+2) && hcount_in < (x_in+WIDTH+2)) &&
            (vcount_in >= (y_in) && vcount_in < (y_in+HEIGHT)))
            pixel_out = pix_color;
        else pixel_out = pixel_in;
    end
endmodule