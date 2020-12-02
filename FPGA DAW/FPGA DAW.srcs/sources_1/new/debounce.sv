`timescale 1ns / 1ps

module debounce (input logic clk_in,
                 input logic rst_in,
                 input logic noisy_in,
                 output logic clean_out);

   logic [19:0] count;
   logic new_input;

   always_ff @(posedge clk_in)
     if (rst_in) begin 
        new_input <= noisy_in; 
        clean_out <= noisy_in; 
        count <= 0; end
     else if (noisy_in != new_input) begin new_input<=noisy_in; count <= 0; end
     else if (count == 10) clean_out <= new_input;
     else count <= count+1;


endmodule