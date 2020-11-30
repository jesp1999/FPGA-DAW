`timescale 1ns / 1ps


module input_handler(
                     input logic clk_in,
                     input logic rst_in,
                     input logic data_clk_in,
                     input logic data_in,
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
    logic update;
    logic prev_update;
    
    keyboard_handler kh(.data_clk_in(data_clk_in), .data_in(data_in), .data_out(data_out), .update_out(update));
       
    assign raw_out = data_out;
    
//    assign notes_out = (done) ? notes_out : {76'b0, data_out};
    assign release_next = (data_out[15:8] == RELEASE_NEXT_SC) ? 1'b1 : 1'b0;
    
    always_ff @(posedge clk_in) begin
        if(rst_in) begin
            //notes_out <= 88'b0;
            octave <= 4'b0100;
//            update <= 1'b0;
//            prev_update <= 1'b0;
//            notes_out <= 12'b0;
        end else begin
            if(update && ~prev_update) begin
                case(data_out[7:0])
                    RELEASE_NEXT_SC: begin end
//                    C_SC: notes_out[12] <= ~notes_out[12];
//                    C_SHARP_SC: notes_out[11] <= ~notes_out[11];
//                    D_SC: notes_out[10] <= ~notes_out[10];
//                    D_SHARP_SC: notes_out[9] <= ~notes_out[9];
//                    E_SC: notes_out[8] <= ~notes_out[8];
//                    F_SC: notes_out[7] <= ~notes_out[7];
//                    F_SHARP_SC: notes_out[6] <= ~notes_out[6];
//                    G_SC: notes_out[5] <= ~notes_out[5];
//                    G_SHARP_SC: notes_out[4] <= ~notes_out[4];
//                    A_SC: notes_out[3] <= ~notes_out[3];
//                    A_SHARP_SC: notes_out[2] <= ~notes_out[2];
//                    B_SC: notes_out[1] <= ~notes_out[1];
//                    C2_SC: notes_out[0] <= ~notes_out[0];
                    C_SC: notes_out[12] <= ~release_next;
                    C_SHARP_SC: notes_out[11] <= ~release_next;
                    D_SC: notes_out[10] <= ~release_next;
                    D_SHARP_SC: notes_out[9] <= ~release_next;
                    E_SC: notes_out[8] <= ~release_next;
                    F_SC: notes_out[7] <= ~release_next;
                    F_SHARP_SC: notes_out[6] <= ~release_next;
                    G_SC: notes_out[5] <= ~release_next;
                    G_SHARP_SC: notes_out[4] <= ~release_next;
                    A_SC: notes_out[3] <= ~release_next;
                    A_SHARP_SC: notes_out[2] <= ~release_next;
                    B_SC: notes_out[1] <= ~release_next;
                    C2_SC: notes_out[0] <= ~release_next;
                    OCTAVE_DOWN_SC: if (~release_next) octave <= (octave > LOWEST_OCTAVE) ? octave - 1 : LOWEST_OCTAVE;
                    OCTAVE_UP_SC: if (~release_next) octave <= (octave < HIGHEST_OCTAVE) ? octave + 1 : HIGHEST_OCTAVE;
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