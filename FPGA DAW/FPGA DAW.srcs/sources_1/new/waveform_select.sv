`timescale 1ns / 1ps

module waveform_select(
                       input logic clk_in,
                       input logic rst_in,
                       input logic signal,
                       output logic [2:0] instrument);
    logic last_signal;
    
    always_ff @(posedge clk_in) begin
        if (rst_in) begin
            instrument <= 0;
            last_signal <= signal;
        end
        else begin
            last_signal <= signal;
            if (signal != last_signal && signal == 1) instrument <= instrument + 3'b001;
        end
    end
endmodule