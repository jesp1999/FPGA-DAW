`timescale 1ns / 1ps

module track_select(
                       input logic clk_in,
                       input logic rst_in,
                       input logic signal,
                       output logic [1:0] track);
    logic last_signal;
    
    always_ff @(posedge clk_in) begin
        if (rst_in) begin
            track <= 0;
            last_signal <= signal;
        end
        else begin
            last_signal <= signal;
            if (signal != last_signal && signal == 1) track <= track+1;
        end
    end
endmodule