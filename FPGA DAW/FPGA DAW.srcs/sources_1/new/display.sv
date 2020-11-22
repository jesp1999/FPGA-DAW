`timescale 1ns / 1ps

module display(
               input logic clk_in,
               input logic rst_in,
               input logic [10:0] hcount_in,
               input logic [9:0] vcount_in,
               input logic [12:0] keys,
               input logic waveform,
               output logic [11:0] pixel_out
               );
        
        //registers for pipelining pixels across different clock cycles
        logic [11:0] pixel_reg1;
        logic [11:0] pixel_reg2;
        logic [11:0] pixel_reg3;
        
        parameter WHITE_KEY_WIDTH = 30;
        parameter WHITE_KEY_HEIGHT = 96;
        parameter BLACK_KEY_WIDTH = 14;
        parameter BLACK_KEY_HEIGHT = 64;
       
        parameter KEY_SPACING = 2;
        parameter BLACK_KEY_OFFSET = 3 * (WHITE_KEY_WIDTH + KEY_SPACING) / 4;
        
        parameter KEYBOARD_ORIGIN_X = 32;
        parameter KEYBOARD_ORIGIN_Y = 600;
        
        parameter WHITE_KEY_COLOR = 12'hFFF;
        parameter BLACK_KEY_COLOR = 12'h000;
        parameter WHITE_SELECTED_COLOR = 12'hF00;
        parameter BLACK_SELECTED_COLOR = 12'h00F;
        parameter BACKGROUND_COLOR = 12'hDE3;
        
        ///////////////////////////
        //KEYBOARD//DRAWING//CODE//
        ///////////////////////////
        
        logic [11:0] CPix, CSharpPix, DPix, DSharpPix, EPix, FPix, FSharpPix, GPix, GSharpPix, APix, ASharpPix, BPix;
        logic [11:0] sine_img_pixel, sine_icon_pixel, trng_img_pixel, trng_icon_pixel;
         
        selectable_blob  #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT), .COLOR(WHITE_KEY_COLOR), .SELECTED_COLOR(WHITE_SELECTED_COLOR))
        blob_C (.x_in(KEYBOARD_ORIGIN_X), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[12]), .pixel_in(BACKGROUND_COLOR), .pixel_out(CPix));
        
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
        blob_C2 (.x_in(KEYBOARD_ORIGIN_X + 7*(WHITE_KEY_WIDTH + KEY_SPACING)), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[0]), .pixel_in(ASharpPix), .pixel_out(pixel_reg1));
       
       
        //////////////////////////////////////
        //WAVEFORM//SELECTION//DRAWING//CODE//
        //////////////////////////////////////
       
        parameter WAVE_ICON_SELECTION_WIDTH = 48;
        parameter WAVE_ICON_SELECTION_HEIGHT = 48;
       
        parameter WAVE_ICON_SELECTION_OFFSET = 16;
       
        parameter SINE_WAVE_ICON_ORIGIN_X = 32;
        parameter SINE_WAVE_ICON_ORIGIN_Y = 32;
        parameter TRNG_WAVE_ICON_ORIGIN_X = 32;
        parameter TRNG_WAVE_ICON_ORIGIN_Y = 96;
       
        parameter WAVE_ICON_SELECTED_COLOR = 12'h00F;
       
       
        sinewave_blob blob_sineWaveform (.pixel_clk_in(clk_in), .hcount_in(hcount_in), .vcount_in(vcount_in), .x_in(SINE_WAVE_ICON_ORIGIN_X), .y_in(SINE_WAVE_ICON_ORIGIN_Y), .pixel_in(sine_img_pixel), .pixel_out(sine_icon_pixel));
        
        selectable_blob  #(.WIDTH(WAVE_ICON_SELECTION_WIDTH), .HEIGHT(WAVE_ICON_SELECTION_HEIGHT), .COLOR(BACKGROUND_COLOR), .SELECTED_COLOR(WAVE_ICON_SELECTED_COLOR))
        blob_sinewave_selection (.x_in(SINE_WAVE_ICON_ORIGIN_X - WAVE_ICON_SELECTION_OFFSET), .y_in(SINE_WAVE_ICON_ORIGIN_Y - WAVE_ICON_SELECTION_OFFSET), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(~waveform), .pixel_in(sine_icon_pixel), .pixel_out(trng_img_pixel));
       
        trngwave_blob blob_trngWaveform (.pixel_clk_in(clk_in), .hcount_in(hcount_in), .vcount_in(vcount_in), .x_in(TRNG_WAVE_ICON_ORIGIN_X), .y_in(TRNG_WAVE_ICON_ORIGIN_Y), .pixel_in(trng_img_pixel), .pixel_out(trng_icon_pixel));
       
        selectable_blob  #(.WIDTH(WAVE_ICON_SELECTION_WIDTH), .HEIGHT(WAVE_ICON_SELECTION_HEIGHT), .COLOR(BACKGROUND_COLOR), .SELECTED_COLOR(WAVE_ICON_SELECTED_COLOR))
        blob_trngwave_selection (.x_in(TRNG_WAVE_ICON_ORIGIN_X - WAVE_ICON_SELECTION_OFFSET), .y_in(TRNG_WAVE_ICON_ORIGIN_Y - WAVE_ICON_SELECTION_OFFSET), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(waveform), .pixel_in(trng_icon_pixel), .pixel_out(pixel_out));
       
        always_ff @(posedge clk_in) begin
            sine_img_pixel <= pixel_reg1;
//            pixel_reg3 <= pixel_reg2;
//            pixel_reg2 <= pixel_reg1;
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


module sinewave_blob
   #(parameter WIDTH = 32,     // default picture width
               HEIGHT = 32)    // default picture height)
   (input pixel_clk_in,
    input [10:0] x_in,hcount_in,
    input [9:0] y_in,vcount_in,
    input logic [11:0] pixel_in,
    output logic [11:0] pixel_out);

    logic [9:0] image_addr;   // num of bits for 32x32 ROM
    logic [7:0] image_bits, mapped;
    logic [3:0] red_blended; // alpha blended
    logic [3:0] green_blended;
    logic [3:0] blue_blended;
    // calculate rom address and read the location
    assign image_addr = (hcount_in-x_in) + (vcount_in-y_in) * WIDTH;
    sinewave_image_rom  rom(.clka(pixel_clk_in), .addra(image_addr), .douta(image_bits));
    
    // use color map to create 4 bits R, 4 bits G, 4 bits B
    // since the image is greyscale, just replicate the red pixels
    // and not bother with the other two color maps.
    sinewave_rcm_rom rcm (.clka(pixel_clk_in), .addra(image_bits), .douta(mapped));
    //green_coe gcm (.clka(pixel_clk_in), .addra(image_bits), .douta(green_mapped));
    //blue_coe bcm (.clka(pixel_clk_in), .addra(image_bits), .douta(blue_mapped));
    always_comb begin
        red_blended = pixel_in[11:8] + (mapped[7:4] - pixel_in[11:8]);
        green_blended = pixel_in[7:4] + (mapped[7:4] - pixel_in[7:4]);
        blue_blended = pixel_in[3:0] + (mapped[7:4] - pixel_in[3:0]);
    end
    // note the one clock cycle delay in pixel!
    always_ff @ (posedge pixel_clk_in) begin
        if ((hcount_in >= x_in && hcount_in < (x_in+WIDTH)) &&
            (vcount_in >= y_in && vcount_in < (y_in+HEIGHT)))
            
            pixel_out <= {red_blended, green_blended, blue_blended};
        else pixel_out <= pixel_in;
    end
endmodule

module trngwave_blob
   #(parameter WIDTH = 32,     // default picture width
               HEIGHT = 32)    // default picture height)
   (input pixel_clk_in,
    input [10:0] x_in,hcount_in,
    input [9:0] y_in,vcount_in,
    input logic [11:0] pixel_in,
    output logic [11:0] pixel_out);

    logic [9:0] image_addr;   // num of bits for 32x32 ROM
    logic [7:0] image_bits, mapped;
    logic [3:0] red_blended; // alpha blended
    logic [3:0] green_blended;
    logic [3:0] blue_blended;
    // calculate rom address and read the location
    assign image_addr = (hcount_in-x_in) + (vcount_in-y_in) * WIDTH;
    trngwave_image_rom  rom(.clka(pixel_clk_in), .addra(image_addr), .douta(image_bits));
    
    // use color map to create 4 bits R, 4 bits G, 4 bits B
    // since the image is greyscale, just replicate the red pixels
    // and not bother with the other two color maps.
    trngwave_rcm_rom rcm (.clka(pixel_clk_in), .addra(image_bits), .douta(mapped));
    //green_coe gcm (.clka(pixel_clk_in), .addra(image_bits), .douta(green_mapped));
    //blue_coe bcm (.clka(pixel_clk_in), .addra(image_bits), .douta(blue_mapped));
    always_comb begin
        red_blended = pixel_in[11:8] + (mapped[7:4] - pixel_in[11:8]);
        green_blended = pixel_in[7:4] + (mapped[7:4] - pixel_in[7:4]);
        blue_blended = pixel_in[3:0] + (mapped[7:4] - pixel_in[3:0]);
    end
    // note the one clock cycle delay in pixel!
    always_ff @ (posedge pixel_clk_in) begin
        if ((hcount_in >= x_in && hcount_in < (x_in+WIDTH)) &&
            (vcount_in >= y_in && vcount_in < (y_in+HEIGHT)))
            
            pixel_out <= {red_blended, green_blended, blue_blended};
        else pixel_out <= pixel_in;
    end
endmodule

