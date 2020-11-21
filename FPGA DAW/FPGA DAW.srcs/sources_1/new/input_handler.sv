`timescale 1ns / 1ps


module input_handler(
                     input logic clk_in,
                     input logic rst_in,
                     input logic data_clk_in,
                     input logic data_in,
                     //output logic [87:0] notes_out,
                     output logic [12:0] notes_out,
                     output logic [3:0] octave,
                     output logic [31:0] raw_out
                     );

    parameter RELEASE_NEXT_SC = 8'hF0;
    parameter C_SC = 8'h1C;
    parameter C_SHARP_SC = 8'h1D;
    parameter D_SC = 8'h1B;
    parameter D_SHARP_SC = 8'h24;
    parameter E_SC = 8'h23;
    parameter F_SC = 8'h2B;
    parameter F_SHARP_SC = 8'h2C;
    parameter G_SC = 8'h34;
    parameter G_SHARP_SC = 8'h35;
    parameter A_SC = 8'h33;
    parameter A_SHARP_SC = 8'h3C;
    parameter B_SC = 8'h3B;
    parameter C2_SC = 8'h42;
//    parameter C2_SHARP_SC = 8'h44;
//    parameter D2_SC = 8'h4B;
//    parameter D2_SHARP_SC = 8'h4D;
//    parameter E2_SC = 8'h4C;
//    parameter F2_SC = 8'h52;
    parameter OCTAVE_DOWN_SC = 8'h1A;
    parameter OCTAVE_UP_SC = 8'h22;
    parameter VELOCITY_DOWN_SC = 8'h21;
    parameter VELOCITY_UP_SC = 8'h2A;
    
    parameter NOTES_PER_OCTAVE = 4'd12;
    
    parameter LOWEST_OCTAVE = 4'd1;
    parameter HIGHEST_OCTAVE = 4'd7;
    
    logic release_next;
    logic [31:0] data_out;
    //logic [3:0] octave; //0-indexed, starting from first octave on the 88-key
    logic update;
    logic prev_update;
    
//    logic kb_clk;
    
//    always_ff @(posedge clk_in) begin
//        if(rst_in) begin
//            kb_clk <= 1'b0;
//        end
//        kb_clk <= ~kb_clk;
//    end
    
    keyboard_handler kh(.clk_in(clk_in), .rst_in(rst_in), .data_clk_in(data_clk_in), .data_in(data_in), .data_out(data_out), .update_out(update));
       
    assign raw_out = data_out;
    
//    assign notes_out = (done) ? notes_out : {76'b0, data_out};
    assign release_next = (data_out[15:8] == RELEASE_NEXT_SC) ? 1'b1 : 1'b0;
    
    always_ff @(posedge clk_in) begin
        if(rst_in) begin
            //notes_out <= 88'b0;
            octave <= 4'b0;
        end else begin
            if(update && ~prev_update) begin
                case(data_out[7:0])
                    RELEASE_NEXT_SC: begin end
                    C_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | 13'b100_000_000_0000);
//                            notes_out <= ~((~notes_out) | (1 << (NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | 13'b100_000_000_0000;
//                            notes_out <= notes_out | (1 << (NOTES_PER_OCTAVE*octave));
                        end
                    end
                    C_SHARP_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | 13'b010_000_000_0000);
//                            notes_out <= ~((~notes_out) | (1 << (1 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | 13'b010_000_000_0000;
//                            notes_out <= notes_out | (1 << (1 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    D_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | 13'b001_000_000_0000);
//                            notes_out <= ~((~notes_out) | (1 << (2 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | 13'b001_000_000_0000;
//                            notes_out <= notes_out | (1 << (2 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    D_SHARP_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | 13'b000_100_000_0000);
//                            notes_out <= ~((~notes_out) | (1 << (3 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | 13'b000_100_000_0000;
//                            notes_out <= notes_out | (1 << (3 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    E_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | 13'b000_010_000_0000);
//                            notes_out <= ~((~notes_out) | (1 << (4 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | 13'b000_010_000_0000;
//                            notes_out <= notes_out | (1 << (4 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    F_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | 13'b000_001_000_0000);
//                            notes_out <= ~((~notes_out) | (1 << (5 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | 13'b000_001_000_0000;
//                            notes_out <= notes_out | (1 << (5 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    F_SHARP_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | 13'b000_000_100_0000);
//                            notes_out <= ~((~notes_out) | (1 << (6 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | 13'b000_000_100_0000;
//                            notes_out <= notes_out | (1 << (6 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    G_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | 13'b000_000_010_0000);
//                            notes_out <= ~((~notes_out) | (1 << (7 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | 13'b000_000_010_0000;
//                            notes_out <= notes_out | (1 << (7 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    G_SHARP_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | 13'b000_000_001_0000);
//                            notes_out <= ~((~notes_out) | (1 << (8 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | 13'b000_000_001_0000;
//                            notes_out <= notes_out | (1 << (8 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    A_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | 13'b000_000_000_1000);
//                            notes_out <= ~((~notes_out) | (1 << (9 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | 13'b000_000_000_1000;
//                            notes_out <= notes_out | (1 << (9 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    A_SHARP_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | 13'b000_000_000_0100);
//                            notes_out <= ~((~notes_out) | (1 << (10 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | 13'b000_000_000_0100;
//                            notes_out <= notes_out | (1 << (10 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    B_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | 13'b000_000_000_0010);
//                            notes_out <= ~((~notes_out) | (1 << (11 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | 13'b000_000_000_0010;
//                            notes_out <= notes_out | (1 << (11 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    C2_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | 13'b000_000_000_0001);
//                            notes_out <= ~((~notes_out) | (1 << (12 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | 13'b000_000_000_0001;
//                            notes_out <= notes_out | (1 << (12 + NOTES_PER_OCTAVE*octave));
                        end
                    end
//                    C2_SHARP_SC: begin
//                        if(release_next) begin
//                            notes_out <= ~((~notes_out) | (1 << (13 + NOTES_PER_OCTAVE*octave)));
//                        end else begin
//                            notes_out <= notes_out | (1 << (13 + NOTES_PER_OCTAVE*octave));
//                        end
//                    end
//                    D2_SC: begin
//                        if(release_next) begin
//                            notes_out <= ~((~notes_out) | (1 << (14 + NOTES_PER_OCTAVE*octave)));
//                        end else begin
//                            notes_out <= notes_out | (1 << (14 + NOTES_PER_OCTAVE*octave));
//                        end
//                    end
//                    D2_SHARP_SC: begin
//                        if(release_next) begin
//                            notes_out <= ~((~notes_out) | (1 << (15 + NOTES_PER_OCTAVE*octave)));
//                        end else begin
//                            notes_out <= notes_out | (1 << (15 + NOTES_PER_OCTAVE*octave));
//                        end
//                    end
//                    E2_SC: begin
//                        if(release_next) begin
//                            notes_out <= ~((~notes_out) | (1 << (16 + NOTES_PER_OCTAVE*octave)));
//                        end else begin
//                            notes_out <= notes_out | (1 << (16 + NOTES_PER_OCTAVE*octave));
//                        end
//                    end
//                    F2_SC: begin
//                        if(release_next) begin
//                            notes_out <= ~((~notes_out) | (1 << (17 + NOTES_PER_OCTAVE*octave)));
//                        end else begin
//                            notes_out <= notes_out | (1 << (17 + NOTES_PER_OCTAVE*octave));
//                        end
//                    end
                    OCTAVE_DOWN_SC: begin
                        if(~release_next) begin
                            octave <= (octave > LOWEST_OCTAVE) ? octave - 1 : LOWEST_OCTAVE;
                        end
                    end
                    OCTAVE_UP_SC: begin
                        if(~release_next) begin
                            octave <= (octave < HIGHEST_OCTAVE) ? octave + 1 : HIGHEST_OCTAVE;
                        end
                    end
                    VELOCITY_DOWN_SC: begin
                        //TODO add velocity
                    end
                    VELOCITY_UP_SC: begin
                        //TODO add velocity
                        end
                    default: begin end
                endcase
            end
        end
        prev_update <= update;
    end

endmodule



module keyboard_handler(
                        input logic clk_in,
                        input logic rst_in,
                        input logic data_clk_in,
                        input logic data_in,
                        output logic [31:0] data_out,
                        output logic update_out
                        );

    logic [3:0] counter;

    logic data_clean;
    logic data_clk_clean;
    
    assign data_clean = data_in;
    assign data_clk_clean = data_clk_in;
//    debounce data_debounce (.clk_in(clk_in), .rst_in(rst_in), .noisy_in(data_in), .clean_out(data_clean));
//    debounce data_clk_debounce (.clk_in(clk_in), .rst_in(rst_in), .noisy_in(data_clk_in), .clean_out(data_clk_clean));

    logic [7:0] datacur;
    logic [7:0] dataprev;

    always_ff @(negedge(data_clk_clean)) begin
        case(counter)
        0:;//Start bit
        1:datacur[0] <= data_clean;
        2:datacur[1] <= data_clean;
        3:datacur[2] <= data_clean;
        4:datacur[3] <= data_clean;
        5:datacur[4] <= data_clean;
        6:datacur[5] <= data_clean;
        7:datacur[6] <= data_clean;
        8:datacur[7] <= data_clean;
        9:if (dataprev != datacur) begin
            data_out[31:24] <= data_out[23:16];
            data_out[23:16] <= data_out[15:8];
            data_out[15:8] <= dataprev;
            data_out[7:0] <= datacur;
            dataprev <= datacur;
            update_out <= 1'b1;
        end
        10:update_out <= 1'b0;
        default:;
        endcase
            if(counter <= 9) counter <= counter + 1;
            else if(counter == 10) counter <= 0;
    end
endmodule