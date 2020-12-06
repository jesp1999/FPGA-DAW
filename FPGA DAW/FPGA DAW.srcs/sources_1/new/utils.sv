`timescale 1ns / 1ps

module sum13 (input logic [12:0] bit_vector,
            output logic [3:0] sum);
            
    assign sum = bit_vector[0] + bit_vector[1] + bit_vector[2] + bit_vector[3] + bit_vector[4] + bit_vector[5] + bit_vector[6] + bit_vector[7] + 
                 bit_vector[8] + bit_vector[9] + bit_vector[10] + bit_vector[11] + bit_vector[12];
    
endmodule
