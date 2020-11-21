`timescale 1ns / 1ps


module top_level(
                    input logic ps2_data,
                    input logic ps2_clk,
                    input logic [15:0] sw,
                    input logic clk_100mhz,
                    input logic btnc,
                    input logic btnl,
                    input logic btnr,
                    input logic btnu,
                    input logic btnd,
                    output logic[3:0] vga_r,
                    output logic[3:0] vga_b,
                    output logic[3:0] vga_g,
                    output logic vga_hs,
                    output logic vga_vs,
                    output logic [7:0] an,
                    output logic ca,
                    output logic cb,
                    output logic cc,
                    output logic cd,
                    output logic ce,
                    output logic cf,
                    output logic cg);

    logic [87:0] notes;
    logic [31:0] value;
 
    input_handler input_handler_mod (.clk_in(clk_100mhz), .rst_in(sw[15]), .data_clk_in(ps2_clk), .data_in(ps2_data), .notes_out(notes));
//    waveform_select waveform_sel_mod ();
//    mixer mixer_mod ();
    seven_seg_controller seven_seg_mod (.clk_in(clk_100mhz), .rst_in(sw[15]), .val_in(notes[31:0]), .cat_out({cg,cf,ce,cd,cc,cb,ca}), .an_out(an));
//    effects effects_mod ();
    
//    logic clean_btnu, clean_btnd, clean_btnl, clean_btnr, clean_btnc;
    
//    debounce db_btnu (.clk_in(clk_100mhz), .rst_in(sw[15]), .noisy_in(btnu), .clean_out(clean_btnu));
//    debounce db_btnd (.clk_in(clk_100mhz), .rst_in(sw[15]), .noisy_in(btnd), .clean_out(clean_btnd));
//    debounce db_btnl (.clk_in(clk_100mhz), .rst_in(sw[15]), .noisy_in(btnl), .clean_out(clean_btnl));
//    debounce db_btnr (.clk_in(clk_100mhz), .rst_in(sw[15]), .noisy_in(btnr), .clean_out(clean_btnr));
//    debounce db_btnc (.clk_in(clk_100mhz), .rst_in(sw[15]), .noisy_in(btnc), .clean_out(clean_btnc));
    
    
    
//    logic clk_65mhz;
    
//    clk_wiz_65mhz clk_65mhz_mod(.clk_in1(clk_100mhz), .reset(sw[15]), .clk_65mhz(clk_65mhz));
    
//    logic [10:0] hcount;    // pixel on current line
//    logic [9:0] vcount;     // line number
//    logic hsync, vsync;
//    logic [11:0] pixel;
//    logic [11:0] rgb;
    
//    xvga xvga_mod (.vclock_in(clk_65mhz), .hcount_out(hcount), .vcount_out(vcount), .vsync_out(vsync), .hsync_out(hsync), .blank_out(blank));
//    display display_mod (.clk_in(clk_100mhz), .rst_in(sw[15]), .keys(sw[14:0]), .vcount_in(vcount), .hcount_in(hcount), .pixel_out(pixel));
    
//    logic border = (hcount==0 | hcount==1023 | vcount==0 | vcount==767 |
//                   hcount == 512 | vcount == 384);

//    logic b,hs,vs;
//    always_ff @(posedge clk_65mhz) begin
//        hs <= hsync;
//        vs <= vsync;
//        b <= blank;
//        rgb <= pixel;
//    end

//    // the following lines are required for the Nexys4 VGA circuit - do not change
//    assign vga_r = ~b ? rgb[11:8]: 0;
//    assign vga_g = ~b ? rgb[7:4] : 0;
//    assign vga_b = ~b ? rgb[3:0] : 0;

//    assign vga_hs = ~hs;
//    assign vga_vs = ~vs;
    ila_0  ila_mod (.clk(clk_100mhz), .probe0(ps2_clk), .probe1(ps2_data));
    
endmodule