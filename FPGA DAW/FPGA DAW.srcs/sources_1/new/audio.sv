//PWM generator for audio generation!
module pwm (input clk_in, input rst_in, input [7:0] level_in, output logic pwm_out);
    logic [7:0] count;
    assign pwm_out = count<level_in;
    always_ff @(posedge clk_in)begin
        if (rst_in)begin
            count <= 8'b0;
        end else begin
            count <= count+8'b1;
        end
    end
endmodule

module metronome(input clk_in, input rst_in, input step_in, input signal_main, input signal_secondary, output logic [7:0] amp_out);
    logic [7:0] met_tone_main;
    logic [7:0] met_tone_secondary;
    
    tone_generator  #(.PHASE_INCR(32'd80000000)) met_main(.clk_in(clk_in), .rst_in(rst_in), .octave_in(3'b100), .instrument(3'b000),  
                               .step_in(step_in), .amp_out(met_tone_main));
    
    tone_generator  #(.PHASE_INCR(32'd40000000)) met_sec(.clk_in(clk_in), .rst_in(rst_in), .octave_in(3'b100), .instrument(3'b000),  
                               .step_in(step_in), .amp_out(met_tone_secondary));
                               
    assign amp_out = (signal_main ? (met_tone_main<<1) : 0)
        + (signal_secondary ? (met_tone_secondary<<1) : 0);                            
endmodule

module octave( input clk_in, input rst_in,
                input step_in,
                input logic [12:0] notes,
                input logic [3:0] octave,
                input logic [2:0] instrument,
                output logic [7:0] amp_out);
                
    logic[7:0] tone_C4;
    logic[7:0] tone_Cs4;
    logic[7:0] tone_D4;
    logic[7:0] tone_Ds4;
    logic[7:0] tone_E4;
    logic[7:0] tone_F4;
    logic[7:0] tone_Fs4;
    logic[7:0] tone_G4;
    logic[7:0] tone_Gs4;
    logic[7:0] tone_A4;
    logic[7:0] tone_As4;
    logic[7:0] tone_B4;
    logic[7:0] tone_C5;

    //C4
    tone_generator  #(.PHASE_INCR(32'd23409859)) toneA(.clk_in(clk_in), .rst_in(rst_in), .octave_in(octave), .instrument(instrument),
                               .step_in(step_in), .amp_out(tone_C4));  
    //C#4
    tone_generator  #(.PHASE_INCR(32'd24801882)) toneAs(.clk_in(clk_in), .rst_in(rst_in), .octave_in(octave), .instrument(instrument), 
                               .step_in(step_in), .amp_out(tone_Cs4));  
    //D4
    tone_generator  #(.PHASE_INCR(32'd26276679)) toneB(.clk_in(clk_in), .rst_in(rst_in), .octave_in(octave), .instrument(instrument),  
                               .step_in(step_in), .amp_out(tone_D4));
    //D#4
    tone_generator  #(.PHASE_INCR(32'd27839171)) toneC(.clk_in(clk_in), .rst_in(rst_in), .octave_in(octave), .instrument(instrument),  
                               .step_in(step_in), .amp_out(tone_Ds4));
    //E4
    tone_generator  #(.PHASE_INCR(32'd29494575)) toneCs(.clk_in(clk_in), .rst_in(rst_in), .octave_in(octave), .instrument(instrument),  
                               .step_in(step_in), .amp_out(tone_E4));
    //F4
    tone_generator  #(.PHASE_INCR(32'd31248413)) toneD(.clk_in(clk_in), .rst_in(rst_in), .octave_in(octave), .instrument(instrument),  
                               .step_in(step_in), .amp_out(tone_F4));
    //Fs4
    tone_generator  #(.PHASE_INCR(32'd33106541)) toneDs(.clk_in(clk_in), .rst_in(rst_in), .octave_in(octave), .instrument(instrument), 
                               .step_in(step_in), .amp_out(tone_Fs4));
    //G4
    tone_generator  #(.PHASE_INCR(32'd35075158)) toneE(.clk_in(clk_in), .rst_in(rst_in), .octave_in(octave), .instrument(instrument),  
                               .step_in(step_in), .amp_out(tone_G4));
    //Gs4
    tone_generator  #(.PHASE_INCR(32'd37160835)) toneF(.clk_in(clk_in), .rst_in(rst_in), .octave_in(octave), .instrument(instrument),  
                               .step_in(step_in), .amp_out(tone_Gs4));
    //A4
    tone_generator  #(.PHASE_INCR(32'd39370534)) toneFs(.clk_in(clk_in), .rst_in(rst_in), .octave_in(octave), .instrument(instrument),  
                               .step_in(step_in), .amp_out(tone_A4));
    //As4
    tone_generator  #(.PHASE_INCR(32'd41711627)) toneG(.clk_in(clk_in), .rst_in(rst_in), .octave_in(octave), .instrument(instrument),  
                               .step_in(step_in), .amp_out(tone_As4));
    //B4
    tone_generator  #(.PHASE_INCR(32'd44191930)) toneGs(.clk_in(clk_in), .rst_in(rst_in), .octave_in(octave), .instrument(instrument),  
                               .step_in(step_in), .amp_out(tone_B4));                     
    //C5
    tone_generator  #(.PHASE_INCR(32'd46819719)) toneC5(.clk_in(clk_in), .rst_in(rst_in), .octave_in(octave), .instrument(instrument),  
                               .step_in(step_in), .amp_out(tone_C5));                             
   
    logic [3:0] note_count;
    assign note_count = notes[12]+ 
        notes[11] +
        notes[10] + 
        notes[9] +
        notes[8] +
        notes[7] +
        notes[6] +
        notes[5] +
        notes[4] +
        notes[3] +
        notes[2] +
        notes[1] +
        notes[0];
        
    logic [3:0] note_multiplier;
    always_comb begin
        if (note_count <= 1) note_multiplier = 1;
        else if (note_count <= 2) note_multiplier = 2;
        else if (note_count <= 4) note_multiplier = 3;
        else if (note_count <= 8) note_multiplier = 4;
        else note_multiplier = 5;
    end
         
    assign amp_out = 
    (notes[12] ? (tone_C4>>note_multiplier) : 0) + 
    (notes[11] ? (tone_Cs4>>note_multiplier) : 0) + 
    (notes[10] ? (tone_D4>>note_multiplier) : 0) + 
    (notes[9] ? (tone_Ds4>>note_multiplier) : 0) + 
    (notes[8] ? (tone_E4>>note_multiplier) : 0) + 
    (notes[7] ? (tone_F4>>note_multiplier) : 0) + 
    (notes[6] ? (tone_Fs4>>note_multiplier) : 0) + 
    (notes[5] ? (tone_G4>>note_multiplier) : 0) + 
    (notes[4] ? (tone_Gs4>>note_multiplier) : 0) + 
    (notes[3] ? (tone_A4>>note_multiplier) : 0) + 
    (notes[2] ? (tone_As4>>note_multiplier) : 0) + 
    (notes[1] ? (tone_B4>>note_multiplier) : 0) +
    (notes[0] ? (tone_C5>>note_multiplier): 0); 
              
endmodule

//tone Generator
module tone_generator ( input clk_in, input rst_in, //clock and reset
                        input step_in, //trigger a phase step (rate at which you run sine generator)
                        input [2:0] instrument,
                        input logic [3:0] octave_in,
                        output logic [7:0] amp_out); //output phase   
    parameter PHASE_INCR = 32'b1000_0000_0000_0000_0000_0000_0000_0000>>5; 
    logic [31:0] phase_incr_octave = (PHASE_INCR>>4)<<octave_in;
    logic [31:0] phase;
    logic [7:0] amp, amp_inst0, amp_inst1, amp_inst2, amp_inst3, amp_inst4, amp_inst5, amp_inst6, amp_inst7;
    
    always_comb begin
        case(instrument)
            3'b000: amp = amp_inst0;
            3'b001: amp = amp_inst1;
            3'b010: amp = amp_inst2;
            3'b011: amp = amp_inst3;
            3'b100: amp = amp_inst4;
            3'b101: amp = amp_inst5;
            3'b110: amp = amp_inst6;
            3'b111: amp = amp_inst7;
            default: amp = amp_inst0;
        endcase
    end
    
    assign amp_out = {~amp[7],amp[6:0]};
    lut0 lut_0(.clk_in(clk_in), .phase_in(phase[31:24]), .amp_out(amp_inst0));
    lut1 lut_1(.clk_in(clk_in), .phase_in(phase[31:24]), .amp_out(amp_inst1));
    lut2 lut_2(.clk_in(clk_in), .phase_in(phase[31:24]), .amp_out(amp_inst2));
    lut3 lut_3(.clk_in(clk_in), .phase_in(phase[31:24]), .amp_out(amp_inst3));
    lut4 lut_4(.clk_in(clk_in), .phase_in(phase[31:24]), .amp_out(amp_inst4));
    lut5 lut_5(.clk_in(clk_in), .phase_in(phase[31:24]), .amp_out(amp_inst5));
    lut6 lut_6(.clk_in(clk_in), .phase_in(phase[31:24]), .amp_out(amp_inst6));
    lut7 lut_7(.clk_in(clk_in), .phase_in(phase[31:24]), .amp_out(amp_inst7));
    
    always_ff @(posedge clk_in)begin
        if (rst_in)begin
            phase <= 32'b0;
        end else if (step_in)begin
            phase <= phase+phase_incr_octave;
        end
    end
endmodule

