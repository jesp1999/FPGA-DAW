`timescale 1ns / 1ps

module display(
               input logic clk_in,
               input logic rst_in,
               input logic [10:0] hcount_in,
               input logic [9:0] vcount_in,
               input logic [14:0] keys,
               output logic [11:0] pixel_out
               );
       
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
       
       logic [11:0] CPix, CSharpPix, DPix, DSharpPix, EPix, FPix, FSharpPix, GPix, GSharpPix, APix, ASharpPix, BPix;
       selectable_blob  #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT), .COLOR(WHITE_KEY_COLOR), .SELECTED_COLOR(WHITE_SELECTED_COLOR))
       blob_C (.x_in(KEYBOARD_ORIGIN_X), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[14]), .pixel_in(BACKGROUND_COLOR), .pixel_out(CPix));
       
       selectable_blob  #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT), .COLOR(WHITE_KEY_COLOR), .SELECTED_COLOR(WHITE_SELECTED_COLOR))
       blob_D (.x_in(KEYBOARD_ORIGIN_X + (WHITE_KEY_WIDTH + KEY_SPACING)), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[12]), .pixel_in(CPix), .pixel_out(DPix));
       
       selectable_blob #(.WIDTH(BLACK_KEY_WIDTH), .HEIGHT(BLACK_KEY_HEIGHT), .COLOR(BLACK_KEY_COLOR), .SELECTED_COLOR(BLACK_SELECTED_COLOR))
       blob_CSharp (.x_in(KEYBOARD_ORIGIN_X + BLACK_KEY_OFFSET), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[13]), .pixel_in(DPix), .pixel_out(CSharpPix));
       
       selectable_blob  #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT), .COLOR(WHITE_KEY_COLOR), .SELECTED_COLOR(WHITE_SELECTED_COLOR))
       blob_E (.x_in(KEYBOARD_ORIGIN_X + 2*(WHITE_KEY_WIDTH + KEY_SPACING)), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[10]), .pixel_in(CSharpPix), .pixel_out(EPix));
       
       selectable_blob #(.WIDTH(BLACK_KEY_WIDTH), .HEIGHT(BLACK_KEY_HEIGHT), .COLOR(BLACK_KEY_COLOR), .SELECTED_COLOR(BLACK_SELECTED_COLOR))
       blob_DSharp (.x_in(KEYBOARD_ORIGIN_X + (WHITE_KEY_WIDTH + KEY_SPACING) + BLACK_KEY_OFFSET), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[11]), .pixel_in(EPix), .pixel_out(DSharpPix));
       
       selectable_blob  #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT), .COLOR(WHITE_KEY_COLOR), .SELECTED_COLOR(WHITE_SELECTED_COLOR))
       blob_F (.x_in(KEYBOARD_ORIGIN_X + 3*(WHITE_KEY_WIDTH + KEY_SPACING)), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[9]), .pixel_in(DSharpPix), .pixel_out(FPix));
       
       selectable_blob  #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT), .COLOR(WHITE_KEY_COLOR), .SELECTED_COLOR(WHITE_SELECTED_COLOR))
       blob_G (.x_in(KEYBOARD_ORIGIN_X + 4*(WHITE_KEY_WIDTH + KEY_SPACING)), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[7]), .pixel_in(FPix), .pixel_out(GPix));
       
       selectable_blob #(.WIDTH(BLACK_KEY_WIDTH), .HEIGHT(BLACK_KEY_HEIGHT), .COLOR(BLACK_KEY_COLOR), .SELECTED_COLOR(BLACK_SELECTED_COLOR))
       blob_FSharp (.x_in(KEYBOARD_ORIGIN_X + 3*(WHITE_KEY_WIDTH + KEY_SPACING) + BLACK_KEY_OFFSET), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[8]), .pixel_in(GPix), .pixel_out(FSharpPix));
       
       selectable_blob  #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT), .COLOR(WHITE_KEY_COLOR), .SELECTED_COLOR(WHITE_SELECTED_COLOR))
       blob_A (.x_in(KEYBOARD_ORIGIN_X + 5*(WHITE_KEY_WIDTH + KEY_SPACING)), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[5]), .pixel_in(FSharpPix), .pixel_out(APix));
       
       selectable_blob #(.WIDTH(BLACK_KEY_WIDTH), .HEIGHT(BLACK_KEY_HEIGHT), .COLOR(BLACK_KEY_COLOR), .SELECTED_COLOR(BLACK_SELECTED_COLOR))
       blob_GSharp (.x_in(KEYBOARD_ORIGIN_X + 4*(WHITE_KEY_WIDTH + KEY_SPACING) + BLACK_KEY_OFFSET), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[6]), .pixel_in(APix), .pixel_out(GSharpPix));
       
       selectable_blob  #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT), .COLOR(WHITE_KEY_COLOR), .SELECTED_COLOR(WHITE_SELECTED_COLOR))
       blob_B (.x_in(KEYBOARD_ORIGIN_X + 6*(WHITE_KEY_WIDTH + KEY_SPACING)), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[3]), .pixel_in(GSharpPix), .pixel_out(BPix));
       
       selectable_blob #(.WIDTH(BLACK_KEY_WIDTH), .HEIGHT(BLACK_KEY_HEIGHT), .COLOR(BLACK_KEY_COLOR), .SELECTED_COLOR(BLACK_SELECTED_COLOR))
       blob_ASharp (.x_in(KEYBOARD_ORIGIN_X + 5*(WHITE_KEY_WIDTH + KEY_SPACING) + BLACK_KEY_OFFSET), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[4]), .pixel_in(BPix), .pixel_out(ASharpPix));
       
       selectable_blob  #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT), .COLOR(WHITE_KEY_COLOR), .SELECTED_COLOR(WHITE_SELECTED_COLOR))
       blob_C2 (.x_in(KEYBOARD_ORIGIN_X + 7*(WHITE_KEY_WIDTH + KEY_SPACING)), .y_in(KEYBOARD_ORIGIN_Y), .hcount_in(hcount_in), .vcount_in(vcount_in), .selection(keys[2]), .pixel_in(ASharpPix), .pixel_out(pixel_out));
       

endmodule

        
//////////////////////////////////////////////////////////////////////
//
// blob: generate rectangle on screen
//
//////////////////////////////////////////////////////////////////////
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
