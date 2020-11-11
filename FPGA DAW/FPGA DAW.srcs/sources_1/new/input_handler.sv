`timescale 1ns / 1ps


module input_handler(
                     input logic clk_in,
                     input logic rst_in,
                     input logic data_clk_in,
                     input logic data_in,
                     output logic [87:0] notes_out
                     );

    parameter RELEASE_NEXT_SC = 8'hF0;
    parameter C_SC = 8'h1E;
    parameter C_SHARP_SC = 8'h11;
    parameter D_SC = 8'h1F;
    parameter D_SHARP_SC = 8'h12;
    parameter E_SC = 8'h20;
    parameter F_SC = 8'h21;
    parameter F_SHARP_SC = 8'h14;
    parameter G_SC = 8'h22;
    parameter G_SHARP_SC = 8'h15;
    parameter A_SC = 8'h23;
    parameter A_SHARP_SC = 8'h16;
    parameter B_SC = 8'h24;
    parameter C2_SC = 8'h25;
    parameter C2_SHARP_SC = 8'h18;
    parameter D2_SC = 8'h26;
    parameter D2_SHARP_SC = 8'h19;
    parameter E2_SC = 8'h27;
    parameter F2_SC = 8'h28;
    parameter OCTAVE_DOWN_SC = 8'h2C;
    parameter OCTAVE_UP_SC = 8'h2D;
    parameter VELOCITY_DOWN_SC = 8'h2E;
    parameter VELOCITY_UP_SC = 8'h2F;
    
    parameter NOTES_PER_OCTAVE = 4'd12;
    
    parameter HIGHEST_OCTAVE = 4'd7;
    
    logic done;
    logic release_next;
    logic [7:0] packet;
    logic [3:0] octave; //0-indexed, starting from first octave on the 88-key

    keyboard_handler kh(.clk_in(clk_in), .rst_in(rst_in), .data_clk_in(data_clk_in), .data_in(data_in),
                        .done(done), .packet(packet));
                        
    assign release_next = (packet == RELEASE_NEXT_SC) ? 1'b1 : 1'b0;
    
    always_ff @(posedge clk_in) begin
        if(rst_in) begin
            notes_out <= 88'b0;
            octave <= 4'b0;
        end else begin
            //TODO fix all of these being able to escape their octave (if a problem)
            if(done) begin
                case(packet)
                    RELEASE_NEXT_SC: begin end
                    C_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | (1 << (NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | (1 << (NOTES_PER_OCTAVE*octave));
                        end
                    end
                    C_SHARP_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | (1 << (1 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | (1 << (1 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    D_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | (1 << (2 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | (1 << (2 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    D_SHARP_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | (1 << (3 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | (1 << (3 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    E_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | (1 << (4 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | (1 << (4 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    F_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | (1 << (5 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | (1 << (5 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    F_SHARP_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | (1 << (6 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | (1 << (6 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    G_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | (1 << (7 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | (1 << (7 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    G_SHARP_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | (1 << (8 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | (1 << (8 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    A_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | (1 << (9 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | (1 << (9 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    A_SHARP_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | (1 << (10 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | (1 << (10 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    B_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | (1 << (11 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | (1 << (11 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    C2_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | (1 << (12 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | (1 << (12 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    C2_SHARP_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | (1 << (13 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | (1 << (13 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    D2_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | (1 << (14 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | (1 << (14 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    D2_SHARP_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | (1 << (15 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | (1 << (15 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    E2_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | (1 << (16 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | (1 << (16 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    F2_SC: begin
                        if(release_next) begin
                            notes_out <= ~((~notes_out) | (1 << (17 + NOTES_PER_OCTAVE*octave)));
                        end else begin
                            notes_out <= notes_out | (1 << (17 + NOTES_PER_OCTAVE*octave));
                        end
                    end
                    OCTAVE_DOWN_SC: begin
                        if(~release_next) begin
                            octave <= (octave > 0) ? octave - 1 : 0;
                        end
                    end
                    OCTAVE_UP_SC: begin
                        if(~release_next) begin
                            octave <= (octave < HIGHEST_OCTAVE - 1) ? octave + 1 : HIGHEST_OCTAVE - 1;
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
    end

endmodule



module keyboard_handler(
                        input logic clk_in,
                        input logic rst_in,
                        input logic data_clk_in,
                        input logic data_in,
                        output logic done,
                        output logic [7:0] packet
                        );
                        
    parameter MESSAGE_LENGTH = 11;
    
    logic reading;
    logic [8:0] shift_buffer;
    logic [3:0] counter;
    
    always_ff @(posedge clk_in) begin
        if(rst_in) begin
            reading <= 1'b0;
            shift_buffer <= 9'b111_111_111;
            counter <= 4'b0000;
            done <= 1'b0;
        end else begin
            if(reading) begin //if currently processing a packet
                shift_buffer <= {shift_buffer[8:1], data_in};
                if(counter < MESSAGE_LENGTH-1) begin
                    counter <= counter + 4'b0001;
                end else begin
                    counter <= 4'b0000;
                    packet <= shift_buffer[8:1];
                    reading <= 1'b0;
                    done <= 1'b1;
                end
            end else begin
                if(data_in == 1'b0) begin //start bit low
                    counter <= 4'b1;
                    reading <= 1'b1;
                    shift_buffer <= 9'b111_111_111;
                end
            end
        end
    end
endmodule