//8bit normalized sin(2x)+sin(3x)+sin(5x) lookup, 8bit depth
module lut2(input[7:0] phase_in, input clk_in, output logic[7:0] amp_out);
  always_ff @(posedge clk_in)begin
    case(phase_in)
        8'd0: amp_out<=8'd128;
        8'd1: amp_out<=8'd133;
        8'd2: amp_out<=8'd138;
        8'd3: amp_out<=8'd143;
        8'd4: amp_out<=8'd148;
        8'd5: amp_out<=8'd153;
        8'd6: amp_out<=8'd158;
        8'd7: amp_out<=8'd163;
        8'd8: amp_out<=8'd168;
        8'd9: amp_out<=8'd173;
        8'd10: amp_out<=8'd178;
        8'd11: amp_out<=8'd182;
        8'd12: amp_out<=8'd187;
        8'd13: amp_out<=8'd191;
        8'd14: amp_out<=8'd195;
        8'd15: amp_out<=8'd199;
        8'd16: amp_out<=8'd203;
        8'd17: amp_out<=8'd206;
        8'd18: amp_out<=8'd210;
        8'd19: amp_out<=8'd213;
        8'd20: amp_out<=8'd216;
        8'd21: amp_out<=8'd219;
        8'd22: amp_out<=8'd222;
        8'd23: amp_out<=8'd224;
        8'd24: amp_out<=8'd226;
        8'd25: amp_out<=8'd228;
        8'd26: amp_out<=8'd230;
        8'd27: amp_out<=8'd232;
        8'd28: amp_out<=8'd233;
        8'd29: amp_out<=8'd234;
        8'd30: amp_out<=8'd235;
        8'd31: amp_out<=8'd236;
        8'd32: amp_out<=8'd236;
        8'd33: amp_out<=8'd236;
        8'd34: amp_out<=8'd236;
        8'd35: amp_out<=8'd236;
        8'd36: amp_out<=8'd236;
        8'd37: amp_out<=8'd235;
        8'd38: amp_out<=8'd234;
        8'd39: amp_out<=8'd233;
        8'd40: amp_out<=8'd232;
        8'd41: amp_out<=8'd231;
        8'd42: amp_out<=8'd229;
        8'd43: amp_out<=8'd227;
        8'd44: amp_out<=8'd226;
        8'd45: amp_out<=8'd224;
        8'd46: amp_out<=8'd221;
        8'd47: amp_out<=8'd219;
        8'd48: amp_out<=8'd217;
        8'd49: amp_out<=8'd214;
        8'd50: amp_out<=8'd212;
        8'd51: amp_out<=8'd209;
        8'd52: amp_out<=8'd206;
        8'd53: amp_out<=8'd203;
        8'd54: amp_out<=8'd200;
        8'd55: amp_out<=8'd197;
        8'd56: amp_out<=8'd194;
        8'd57: amp_out<=8'd191;
        8'd58: amp_out<=8'd188;
        8'd59: amp_out<=8'd185;
        8'd60: amp_out<=8'd182;
        8'd61: amp_out<=8'd179;
        8'd62: amp_out<=8'd176;
        8'd63: amp_out<=8'd173;
        8'd64: amp_out<=8'd170;
        8'd65: amp_out<=8'd167;
        8'd66: amp_out<=8'd164;
        8'd67: amp_out<=8'd161;
        8'd68: amp_out<=8'd159;
        8'd69: amp_out<=8'd156;
        8'd70: amp_out<=8'd153;
        8'd71: amp_out<=8'd151;
        8'd72: amp_out<=8'd149;
        8'd73: amp_out<=8'd146;
        8'd74: amp_out<=8'd144;
        8'd75: amp_out<=8'd142;
        8'd76: amp_out<=8'd140;
        8'd77: amp_out<=8'd138;
        8'd78: amp_out<=8'd136;
        8'd79: amp_out<=8'd135;
        8'd80: amp_out<=8'd133;
        8'd81: amp_out<=8'd132;
        8'd82: amp_out<=8'd131;
        8'd83: amp_out<=8'd130;
        8'd84: amp_out<=8'd129;
        8'd85: amp_out<=8'd128;
        8'd86: amp_out<=8'd127;
        8'd87: amp_out<=8'd126;
        8'd88: amp_out<=8'd126;
        8'd89: amp_out<=8'd125;
        8'd90: amp_out<=8'd125;
        8'd91: amp_out<=8'd125;
        8'd92: amp_out<=8'd125;
        8'd93: amp_out<=8'd125;
        8'd94: amp_out<=8'd125;
        8'd95: amp_out<=8'd125;
        8'd96: amp_out<=8'd125;
        8'd97: amp_out<=8'd125;
        8'd98: amp_out<=8'd126;
        8'd99: amp_out<=8'd126;
        8'd100: amp_out<=8'd126;
        8'd101: amp_out<=8'd127;
        8'd102: amp_out<=8'd127;
        8'd103: amp_out<=8'd128;
        8'd104: amp_out<=8'd128;
        8'd105: amp_out<=8'd129;
        8'd106: amp_out<=8'd129;
        8'd107: amp_out<=8'd130;
        8'd108: amp_out<=8'd130;
        8'd109: amp_out<=8'd131;
        8'd110: amp_out<=8'd131;
        8'd111: amp_out<=8'd132;
        8'd112: amp_out<=8'd132;
        8'd113: amp_out<=8'd132;
        8'd114: amp_out<=8'd133;
        8'd115: amp_out<=8'd133;
        8'd116: amp_out<=8'd133;
        8'd117: amp_out<=8'd133;
        8'd118: amp_out<=8'd133;
        8'd119: amp_out<=8'd133;
        8'd120: amp_out<=8'd133;
        8'd121: amp_out<=8'd132;
        8'd122: amp_out<=8'd132;
        8'd123: amp_out<=8'd131;
        8'd124: amp_out<=8'd131;
        8'd125: amp_out<=8'd130;
        8'd126: amp_out<=8'd129;
        8'd127: amp_out<=8'd128;
        8'd128: amp_out<=8'd128;
        8'd129: amp_out<=8'd126;
        8'd130: amp_out<=8'd125;
        8'd131: amp_out<=8'd124;
        8'd132: amp_out<=8'd123;
        8'd133: amp_out<=8'd121;
        8'd134: amp_out<=8'd119;
        8'd135: amp_out<=8'd118;
        8'd136: amp_out<=8'd116;
        8'd137: amp_out<=8'd114;
        8'd138: amp_out<=8'd112;
        8'd139: amp_out<=8'd110;
        8'd140: amp_out<=8'd108;
        8'd141: amp_out<=8'd106;
        8'd142: amp_out<=8'd104;
        8'd143: amp_out<=8'd102;
        8'd144: amp_out<=8'd100;
        8'd145: amp_out<=8'd97;
        8'd146: amp_out<=8'd95;
        8'd147: amp_out<=8'd93;
        8'd148: amp_out<=8'd90;
        8'd149: amp_out<=8'd88;
        8'd150: amp_out<=8'd86;
        8'd151: amp_out<=8'd83;
        8'd152: amp_out<=8'd81;
        8'd153: amp_out<=8'd79;
        8'd154: amp_out<=8'd77;
        8'd155: amp_out<=8'd75;
        8'd156: amp_out<=8'd72;
        8'd157: amp_out<=8'd70;
        8'd158: amp_out<=8'd69;
        8'd159: amp_out<=8'd67;
        8'd160: amp_out<=8'd65;
        8'd161: amp_out<=8'd63;
        8'd162: amp_out<=8'd62;
        8'd163: amp_out<=8'd60;
        8'd164: amp_out<=8'd59;
        8'd165: amp_out<=8'd58;
        8'd166: amp_out<=8'd57;
        8'd167: amp_out<=8'd56;
        8'd168: amp_out<=8'd55;
        8'd169: amp_out<=8'd55;
        8'd170: amp_out<=8'd54;
        8'd171: amp_out<=8'd54;
        8'd172: amp_out<=8'd54;
        8'd173: amp_out<=8'd54;
        8'd174: amp_out<=8'd54;
        8'd175: amp_out<=8'd54;
        8'd176: amp_out<=8'd55;
        8'd177: amp_out<=8'd56;
        8'd178: amp_out<=8'd56;
        8'd179: amp_out<=8'd57;
        8'd180: amp_out<=8'd59;
        8'd181: amp_out<=8'd60;
        8'd182: amp_out<=8'd62;
        8'd183: amp_out<=8'd63;
        8'd184: amp_out<=8'd65;
        8'd185: amp_out<=8'd67;
        8'd186: amp_out<=8'd69;
        8'd187: amp_out<=8'd72;
        8'd188: amp_out<=8'd74;
        8'd189: amp_out<=8'd77;
        8'd190: amp_out<=8'd79;
        8'd191: amp_out<=8'd82;
        8'd192: amp_out<=8'd85;
        8'd193: amp_out<=8'd88;
        8'd194: amp_out<=8'd91;
        8'd195: amp_out<=8'd94;
        8'd196: amp_out<=8'd97;
        8'd197: amp_out<=8'd101;
        8'd198: amp_out<=8'd104;
        8'd199: amp_out<=8'd108;
        8'd200: amp_out<=8'd111;
        8'd201: amp_out<=8'd114;
        8'd202: amp_out<=8'd118;
        8'd203: amp_out<=8'd121;
        8'd204: amp_out<=8'd125;
        8'd205: amp_out<=8'd128;
        8'd206: amp_out<=8'd132;
        8'd207: amp_out<=8'd135;
        8'd208: amp_out<=8'd138;
        8'd209: amp_out<=8'd141;
        8'd210: amp_out<=8'd145;
        8'd211: amp_out<=8'd148;
        8'd212: amp_out<=8'd151;
        8'd213: amp_out<=8'd154;
        8'd214: amp_out<=8'd156;
        8'd215: amp_out<=8'd159;
        8'd216: amp_out<=8'd161;
        8'd217: amp_out<=8'd164;
        8'd218: amp_out<=8'd166;
        8'd219: amp_out<=8'd168;
        8'd220: amp_out<=8'd170;
        8'd221: amp_out<=8'd172;
        8'd222: amp_out<=8'd173;
        8'd223: amp_out<=8'd175;
        8'd224: amp_out<=8'd176;
        8'd225: amp_out<=8'd177;
        8'd226: amp_out<=8'd178;
        8'd227: amp_out<=8'd179;
        8'd228: amp_out<=8'd179;
        8'd229: amp_out<=8'd179;
        8'd230: amp_out<=8'd179;
        8'd231: amp_out<=8'd179;
        8'd232: amp_out<=8'd179;
        8'd233: amp_out<=8'd179;
        8'd234: amp_out<=8'd178;
        8'd235: amp_out<=8'd177;
        8'd236: amp_out<=8'd176;
        8'd237: amp_out<=8'd175;
        8'd238: amp_out<=8'd173;
        8'd239: amp_out<=8'd172;
        8'd240: amp_out<=8'd170;
        8'd241: amp_out<=8'd168;
        8'd242: amp_out<=8'd166;
        8'd243: amp_out<=8'd164;
        8'd244: amp_out<=8'd162;
        8'd245: amp_out<=8'd159;
        8'd246: amp_out<=8'd157;
        8'd247: amp_out<=8'd154;
        8'd248: amp_out<=8'd152;
        8'd249: amp_out<=8'd149;
        8'd250: amp_out<=8'd146;
        8'd251: amp_out<=8'd143;
        8'd252: amp_out<=8'd140;
        8'd253: amp_out<=8'd137;
        8'd254: amp_out<=8'd134;
        8'd255: amp_out<=8'd131;
    endcase
  end
endmodule