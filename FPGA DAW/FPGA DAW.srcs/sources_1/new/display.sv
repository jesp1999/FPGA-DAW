`timescale 1ns / 1ps

module display(
               input logic clk_in,
               input logic rst_in,
               input logic [10:0] hcount_in,
               input logic [9:0] vcount_in,
               input logic [12:0] keys [3:0],
               input logic waveform,
               output logic [11:0] pixel_out
               );
        
        //registers for pipelining pixels across different clock cycles
        logic [11:0] pixel_reg1;
        logic [11:0] pixel_reg2;
        logic [11:0] pixel_reg3;
        
        parameter BACKGROUND_COLOR = 12'hDE3;
        
        ///////////////////////////
        //KEYBOARD//DRAWING//CODE//
        ///////////////////////////
        
        logic [11:0] keyboard_track0_pixel, keyboard_track1_pixel, keyboard_track2_pixel, keyboard_track3_pixel;
        keyboard_blob #(.KEYBOARD_ORIGIN_X(4), .KEYBOARD_ORIGIN_Y(600))
        blob_keyboard_track0 (.keys(keys[0]), .hcount_in(hcount_in), .vcount_in(vcount_in), .pixel_in(BACKGROUND_COLOR), .pixel_out(keyboard_track0_pixel));
        
        keyboard_blob #(.KEYBOARD_ORIGIN_X(4 + 238 + 18), .KEYBOARD_ORIGIN_Y(600))
        blob_keyboard_track1 (.keys(keys[1]), .hcount_in(hcount_in), .vcount_in(vcount_in), .pixel_in(BACKGROUND_COLOR), .pixel_out(keyboard_track1_pixel));
        
        keyboard_blob #(.KEYBOARD_ORIGIN_X(4 + 476 + 36), .KEYBOARD_ORIGIN_Y(600))
        blob_keyboard_track2 (.keys(keys[2]), .hcount_in(hcount_in), .vcount_in(vcount_in), .pixel_in(BACKGROUND_COLOR), .pixel_out(keyboard_track2_pixel));
        
        keyboard_blob #(.KEYBOARD_ORIGIN_X(4 + 714 + 54), .KEYBOARD_ORIGIN_Y(600))
        blob_keyboard_track3 (.keys(keys[3]), .hcount_in(hcount_in), .vcount_in(vcount_in), .pixel_in(BACKGROUND_COLOR), .pixel_out(keyboard_track3_pixel));
       
       
        //////////////////////////////////////
        //WAVEFORM//SELECTION//DRAWING//CODE//
        //////////////////////////////////////
       
//        parameter WAVE_ICON_SELECTION_WIDTH = 48;
//        parameter WAVE_ICON_SELECTION_HEIGHT = 48;
       
//        parameter WAVE_ICON_SELECTION_OFFSET = 16;
       
//        parameter SINE_WAVE_ICON_ORIGIN_X = 32;
//        parameter SINE_WAVE_ICON_ORIGIN_Y = 32;
//        parameter TRNG_WAVE_ICON_ORIGIN_X = 32;
//        parameter TRNG_WAVE_ICON_ORIGIN_Y = 96;
       
//        parameter WAVE_ICON_SELECTED_COLOR = 12'h00F;
       
       
//        selectable_blob  #(.WIDTH(WAVE_ICON_SELECTION_WIDTH), .HEIGHT(WAVE_ICON_SELECTION_HEIGHT), .COLOR(BACKGROUND_COLOR), .SELECTED_COLOR(WAVE_ICON_SELECTED_COLOR))
//        blob_sinewave_selection (.x_in(SINE_WAVE_ICON_ORIGIN_X - WAVE_ICON_SELECTION_OFFSET), .y_in(SINE_WAVE_ICON_ORIGIN_Y - WAVE_ICON_SELECTION_OFFSET), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(~waveform), .pixel_in(sine_icon_pixel), .pixel_out(sine_img_pixel));
      
//        sinewave_blob blob_sineWaveform (.pixel_clk_in(clk_in), .hcount_in(hcount_in), .vcount_in(vcount_in), .x_in(SINE_WAVE_ICON_ORIGIN_X), .y_in(SINE_WAVE_ICON_ORIGIN_Y), .pixel_in(sine_img_pixel), .pixel_out(trng_icon_pixel));

//        selectable_blob  #(.WIDTH(WAVE_ICON_SELECTION_WIDTH), .HEIGHT(WAVE_ICON_SELECTION_HEIGHT), .COLOR(BACKGROUND_COLOR), .SELECTED_COLOR(WAVE_ICON_SELECTED_COLOR))
//        blob_trngwave_selection (.x_in(TRNG_WAVE_ICON_ORIGIN_X - WAVE_ICON_SELECTION_OFFSET), .y_in(TRNG_WAVE_ICON_ORIGIN_Y - WAVE_ICON_SELECTION_OFFSET), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(waveform), .pixel_in(trng_icon_pixel), .pixel_out(trng_img_pixel));
       
//        trngwave_blob blob_trngWaveform (.pixel_clk_in(clk_in), .hcount_in(hcount_in), .vcount_in(vcount_in), .x_in(TRNG_WAVE_ICON_ORIGIN_X), .y_in(TRNG_WAVE_ICON_ORIGIN_Y), .pixel_in(trng_img_pixel), .pixel_out(pixel_out));
       
        
        always_ff @(posedge clk_in) begin
            if (keyboard_track0_pixel != BACKGROUND_COLOR) begin
                pixel_out <= keyboard_track0_pixel;
            end else if (keyboard_track1_pixel != BACKGROUND_COLOR) begin
                pixel_out <= keyboard_track1_pixel;
            end else if (keyboard_track2_pixel != BACKGROUND_COLOR) begin
                pixel_out <= keyboard_track2_pixel;
            end else if (keyboard_track3_pixel != BACKGROUND_COLOR) begin
                pixel_out <= keyboard_track3_pixel;
            end else begin
                pixel_out <= BACKGROUND_COLOR;
            end
//            sine_img_pixel <= pixel_reg1;
//            pixel_reg3 <= pixel_reg2;
//            pixel_reg2 <= pixel_reg1;
        end
       
endmodule

module keyboard_blob
   #(parameter KEYBOARD_ORIGIN_X = 0,
               KEYBOARD_ORIGIN_Y = 0,
               WHITE_KEY_WIDTH = 28,
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


module sinewave_blob
   #(parameter WIDTH = 32,     // default picture width
               HEIGHT = 32)    // default picture height)
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
    sinewave_image_rom  rom(.clka(pixel_clk_in), .addra(image_addr), .douta(image_bits));
    
    sinewave_rcm_rom rcm (.clka(pixel_clk_in), .addra(image_bits), .douta(mapped));
    assign pix_color = mapped[7:4];
    
    //assign pixel_out = {pix_color, pix_color, pix_color};
    
    // note the one clock cycle delay in pixel!
    always_ff @ (posedge pixel_clk_in) begin
        if ((hcount_in >= x_in && hcount_in < (x_in+WIDTH)) &&
            (vcount_in >= y_in && vcount_in < (y_in+HEIGHT)))
            pixel_out <= {pix_color, pix_color, pix_color};
        else pixel_out <= pixel_in;
    end
endmodule

module trngwave_blob
   #(parameter WIDTH = 32,     // default picture width
               HEIGHT = 32)    // default picture height)
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
    trngwave_image_rom  rom(.clka(pixel_clk_in), .addra(image_addr), .douta(image_bits));
    
    trngwave_rcm_rom rcm (.clka(pixel_clk_in), .addra(image_bits), .douta(mapped));
    assign pix_color = mapped[7:4];
    
    //assign pixel_out = {pix_color, pix_color, pix_color};
    
    // note the one clock cycle delay in pixel!
    always_ff @ (posedge pixel_clk_in) begin
        if ((hcount_in >= x_in && hcount_in < (x_in+WIDTH)) &&
            (vcount_in >= y_in && vcount_in < (y_in+HEIGHT)))
            pixel_out <= {pix_color, pix_color, pix_color};
        else pixel_out <= pixel_in;
    end
endmodule

