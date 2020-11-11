`timescale 1ns / 1ps

module binary_to_seven_seg( 
                            input logic [3:0] val_in,
                            output logic [6:0] led_out
);

    always_comb begin
        case(val_in)
            4'd0: led_out = 7'b011_1111;
            4'd1: led_out = 7'b000_0110;
            4'd2: led_out = 7'b101_1011;
            4'd3: led_out = 7'b100_1111;
            4'd4: led_out = 7'b110_0110;
            4'd5: led_out = 7'b110_1101;
            4'd6: led_out = 7'b111_1101;
            4'd7: led_out = 7'b000_0111;
            4'd8: led_out = 7'b111_1111;
            4'd9: led_out = 7'b110_1111;
            4'd10: led_out = 7'b111_0111;
            4'd11: led_out = 7'b111_1100;
            4'd12: led_out = 7'b011_1001;
            4'd13: led_out = 7'b101_1110;
            4'd14: led_out = 7'b111_1001;
            4'd15: led_out = 7'b111_0001;
            default: led_out = 7'b000_0000;
        endcase
    end

endmodule //binary_to_hex