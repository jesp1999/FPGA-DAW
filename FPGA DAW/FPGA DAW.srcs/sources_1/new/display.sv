`timescale 1ns / 1ps

module display(
               input logic clk_in,
               input logic rst_in,
               input logic [10:0] hcount_next_in,
               input logic [9:0] vcount_next_in,
               input logic [10:0] hcount_curr_in,
               input logic [9:0] vcount_curr_in,
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
      
      
        logic [11:0] octave_text_pixel, instrument_text_pixel, volume_text_pixel;
        logic [11:0] volume_text_pixel_reg1, volume_text_pixel_reg2;
        
        octave_text_blob blob_octave_text (.pixel_clk_in(clk_in), .hcount_in(hcount_next_in), .vcount_in(vcount_next_in), .x_in(2), .y_in(350 + 96 + 32 + 2), .pixel_in(BACKGROUND_COLOR), .pixel_out(octave_text_pixel));

        instrument_text_blob blob_instrument_text (.pixel_clk_in(clk_in), .hcount_in(hcount_next_in), .vcount_in(vcount_next_in), .x_in(2), .y_in(350 + 96 + 64 + 2), .pixel_in(octave_text_pixel), .pixel_out(instrument_text_pixel));

        volume_text_blob blob_volume_text (.pixel_clk_in(clk_in), .hcount_in(hcount_next_in), .vcount_in(vcount_next_in), .x_in(2), .y_in(350 + 96 + 96 + 2), .pixel_in(instrument_text_pixel), .pixel_out(volume_text_pixel));
       
        
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
            end else if (volume_text_pixel != BACKGROUND_COLOR) begin
                pixel_out <= volume_text_pixel;
            end else begin
                pixel_out <= BACKGROUND_COLOR;
            end
//            volume_text_pixel_reg2 <= volume_text_pixel_reg1;
//            volume_text_pixel_reg1 <= volume_text_pixel;
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

    logic [9:0] image_addr;   // num of bits for 32x32 ROM
    logic [7:0] image_bits, mapped;
    logic [3:0] pix_color;
    
    // calculate rom address and read the location
    assign image_addr = (hcount_in-x_in) + (vcount_in-y_in) * WIDTH;
    octave_text_image_rom  rom(.clka(pixel_clk_in), .addra(image_addr), .douta(image_bits));
    
    assign pix_color = (image_bits == 8'h00) ? 8'hFF : 8'h00;
    
    //assign pixel_out = {pix_color, pix_color, pix_color};
    
    // note the one clock cycle delay in pixel!
    always_ff @ (posedge pixel_clk_in) begin
        if ((hcount_in >= x_in && hcount_in < (x_in+WIDTH)) &&
            (vcount_in >= y_in && vcount_in < (y_in+HEIGHT)))
            pixel_out <= {pix_color, pix_color, pix_color};
        else pixel_out <= pixel_in;
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
    
    //assign pixel_out = {pix_color, pix_color, pix_color};
    
    // note the one clock cycle delay in pixel!
    always_ff @ (posedge pixel_clk_in) begin
        if ((hcount_in >= x_in && hcount_in < (x_in+WIDTH)) &&
            (vcount_in >= y_in && vcount_in < (y_in+HEIGHT)))
            pixel_out <= {pix_color, pix_color, pix_color};
        else pixel_out <= pixel_in;
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

    logic [9:0] image_addr;   // num of bits for 32x32 ROM
    logic [7:0] image_bits, mapped;
    logic [3:0] pix_color;
    
    // calculate rom address and read the location
    assign image_addr = (hcount_in-x_in) + (vcount_in-y_in) * WIDTH;
    volume_text_image_rom  rom(.clka(pixel_clk_in), .addra(image_addr), .douta(image_bits));
    
    assign pix_color = (image_bits == 8'h00) ? 8'hFF : 8'h00;
    
    //assign pixel_out = {pix_color, pix_color, pix_color};
    
    // note the one clock cycle delay in pixel!
    always_ff @ (posedge pixel_clk_in) begin
        if ((hcount_in >= x_in && hcount_in < (x_in+WIDTH)) &&
            (vcount_in >= y_in && vcount_in < (y_in+HEIGHT)))
            pixel_out <= {pix_color, pix_color, pix_color};
        else pixel_out <= pixel_in;
    end
endmodule