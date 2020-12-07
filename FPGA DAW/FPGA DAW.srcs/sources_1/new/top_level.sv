`timescale 1ns / 1ps


module top_level(
                    input logic ps2_data,
                    input logic ps2_clk,
                    input logic [15:0] sw,
                    input logic clk_100mhz,
                    input logic btnc,
                    input logic btnl,
                    input logic btnr,
                    input logic btnu,
                    input logic btnd,
                    output logic[3:0] vga_r,
                    output logic[3:0] vga_b,
                    output logic[3:0] vga_g,
                    output logic vga_hs,
                    output logic vga_vs,
                    output logic [15:0] led,
                    output logic [7:0] an,
                    output logic ca,
                    output logic cb,
                    output logic cc,
                    output logic cd,
                    output logic ce,
                    output logic cf,
                    output logic cg,
                    output logic aud_pwm,
                    output logic aud_sd);
    
    parameter SAMPLE_COUNT = 1354;//gets approximately (will generate audio at approx 48 kHz sample rate.
 
    logic clean_btnu, clean_btnd, clean_btnl, clean_btnr; 
 
    logic [15:0] sample_counter;
    logic sample_trigger;
    logic enable;
    logic [7:0] recorder_data;             
    logic [7:0] vol_out;
    logic pwm_val; //pwm signal (HI/LO)
 
    logic clean_record_btn;
    
    logic clk_65mhz;
    logic clk_65mhz_locked;
    clk_wiz_65mhz clk_65mhz_mod(.clk_in1(clk_100mhz), .reset(0), .clk_65mhz(clk_65mhz), .locked(clk_65mhz_locked));
 
    assign aud_sd = 1;
    //assign led = sw; //just to look pretty 
    assign sample_trigger = (sample_counter == SAMPLE_COUNT);
 
    always_ff @(posedge clk_65mhz)begin
        if (sample_counter == SAMPLE_COUNT)begin
            sample_counter <= 16'b0;
        end else begin
            sample_counter <= sample_counter + 16'b1;
        end
    end
 
    logic [1:0] track;
    logic [7:0] raw_audio_out [3:0];
    logic [12:0] notes;
    logic [12:0] notes_to_play [3:0];
    logic [2:0] instrument;
    logic [2:0] instrument_to_play [3:0];
    logic [2:0] octave;
    logic [2:0] octave_to_play [3:0];
    logic [7:0] beat_count;
    logic [2:0] volume_to_play [3:0];
    logic [7:0] latest_valid_beat [3:0];
    logic metronome_main, metronome_secondary;
    logic [7:0] metronome_raw_audio;
    assign volume_to_play[0] = sw[15:13];
    assign volume_to_play[1] = sw[12:10];
    assign volume_to_play[2] = sw[9:7];
    assign volume_to_play[3] = sw[6:4];
 
    recorder my_rec (.clk_in(clk_65mhz), .rst_in(btnc), .rst_beat_count(clean_btnl), .rst_track(clean_btnr),
        .notes_in(notes),
        .octave_in(octave),
        .instrument_in(instrument),
        .record(sw[0]), // CHANGE LATER
        .track(track),
        .beat_count(beat_count),
        .notes_out(notes_to_play),
        .octave_out(octave_to_play),
        .instrument_out(instrument_to_play),
        .latest_valid_beat(latest_valid_beat),
        .metronome_main(metronome_main),
        .metronome_secondary(metronome_secondary));
        
    octave track_0 (.clk_in(clk_65mhz), .rst_in(btnc),
        .step_in(sample_trigger),
        .amp_out(raw_audio_out[0]),
        .notes(notes_to_play[0]),
        .octave(octave_to_play[0]),
        .instrument(instrument_to_play[0]));    
        
    octave track_1 (.clk_in(clk_65mhz), .rst_in(btnc),
        .step_in(sample_trigger),
        .amp_out(raw_audio_out[1]),
        .notes(notes_to_play[1]),
        .octave(octave_to_play[1]),
        .instrument(instrument_to_play[1])); 
 
     octave track_2 (.clk_in(clk_65mhz), .rst_in(btnc),
        .step_in(sample_trigger),
        .amp_out(raw_audio_out[2]),
        .notes(notes_to_play[2]),
        .octave(octave_to_play[2]),
        .instrument(instrument_to_play[2])); 
  
      octave track_3 (.clk_in(clk_65mhz), .rst_in(btnc),
        .step_in(sample_trigger),
        .amp_out(raw_audio_out[3]),
        .notes(notes_to_play[3]),
        .octave(octave_to_play[3]),
        .instrument(instrument_to_play[3]));
        
      metronome my_met (.clk_in(clk_65mhz), .rst_in(btnc),
        .step_in(sample_trigger),
        .signal_main(metronome_main),
        .signal_secondary(metronome_secondary),
        .amp_out(metronome_raw_audio));
        
//    volume_control vc (.vol_in(sw[15:13]),
//                       .signal_in(raw_audio_out[0]), .signal_out(vol_out));
    pwm (.clk_in(clk_65mhz), .rst_in(btnc), .level_in({~vol_out[7],vol_out[6:0]}), .pwm_out(pwm_val));
    assign aud_pwm = pwm_val?1'bZ:1'b0; 
    
//    logic [87:0] notes;
    logic [31:0] raw_keyboard;

    debounce db_btnu (.clk_in(clk_65mhz), .rst_in(btnc), .noisy_in(btnu), .clean_out(clean_btnu));
    debounce db_btnd (.clk_in(clk_65mhz), .rst_in(btnc), .noisy_in(btnd), .clean_out(clean_btnd));
    debounce db_btnl (.clk_in(clk_65mhz), .rst_in(btnc), .noisy_in(btnl), .clean_out(clean_btnl));
    debounce db_btnr (.clk_in(clk_65mhz), .rst_in(btnc), .noisy_in(btnr), .clean_out(clean_btnr));

    input_handler input_handler_mod (.clk_in(clk_65mhz), .rst_in(btnc), .data_clk_in(ps2_clk), .data_in(ps2_data), .notes_out(notes), .octave(octave), .raw_out(raw_keyboard));
    
    logic waveform_select_signal;
    logic track_select_signal;
    assign waveform_select_signal = clean_btnd;
    assign track_select_signal = clean_btnu;
    
    waveform_select waveform_sel_mod (.clk_in(clk_65mhz), .rst_in(btnc), .signal(waveform_select_signal), .instrument(instrument));
    
    track_select track_sel_mod (.clk_in(clk_65mhz), .rst_in(btnc), .signal(track_select_signal), .track(track));
    
    mixer mixer_mod (.clk_in(clk_65mhz), .rst_in(btnc), .volume(volume_to_play), .met_volume(sw[3:1]),
                     .audio0_in(raw_audio_out[0]), 
                     .audio1_in(raw_audio_out[1]), 
                     .audio2_in(raw_audio_out[2]), 
                     .audio3_in(raw_audio_out[3]), 
                     .metronome_in(metronome_raw_audio), .audio_out(vol_out));
    
    seven_seg_controller seven_seg_mod (.clk_in(clk_65mhz), .rst_in(btnc), .val_in({latest_valid_beat[0], metronome_raw_audio, 7'b0, metronome_main, beat_count}), .cat_out({1'b0,cg,cf,ce,cd,cc,cb,ca}), .an_out(an));
//    effects effects_mod ();
    
    
    assign led[2:0] = {metronome_main,track};
    
    // hcount represents hcount 2 ticks in the future, hcount_reg2 is the current hcount (actually displayed)
    // this allows to predict what the image should be and initiate a rom read early
    logic [10:0] hcount_t_plus_2, hcount_t_plus_1, hcount_t;    // pixel on current line
    logic [9:0] vcount_t_plus_2, vcount_t_plus_1, vcount_t;     // line number
    logic hsync, vsync;
    logic [11:0] pixel;
    logic [11:0] rgb;
    
    xvga xvga_mod (.vclock_in(clk_65mhz), .hcount_out(hcount_t_plus_2), .vcount_out(vcount_t_plus_2), .vsync_out(vsync), .hsync_out(hsync), .blank_out(blank));
    display display_mod (.clk_in(clk_65mhz), .rst_in(btnc), .keys(notes_to_play), .beat(beat_count), .octave(octave_to_play), .volume(volume_to_play), .instrument(instrument_to_play),
                         .vcount_curr_in(vcount_t), .hcount_curr_in(hcount_t), .vcount_next_in(vcount_t_plus_2), .hcount_next_in(hcount_t_plus_2), .pixel_out(pixel));
    
    logic border = (hcount_t==0 | hcount_t==1023 | vcount_t==0 | vcount_t==767 |
                   hcount_t == 512 | vcount_t == 384);

    logic b,hs,vs;
    always_ff @(posedge clk_65mhz) begin
        hcount_t <= hcount_t_plus_1;
        hcount_t_plus_1 <= hcount_t_plus_2;
        vcount_t <= vcount_t_plus_1;
        vcount_t_plus_1 <= vcount_t_plus_2;
        hs <= hsync;
        vs <= vsync;
        b <= blank;
        rgb <= pixel;
    end

    // the following lines are required for the Nexys4 VGA circuit - do not change
    assign vga_r = ~b ? rgb[11:8]: 0;
    assign vga_g = ~b ? rgb[7:4] : 0;
    assign vga_b = ~b ? rgb[3:0] : 0;

    assign vga_hs = ~hs;
    assign vga_vs = ~vs;
    
    
    //ila_0  ila_mod (.clk(clk_65mhz), .probe0(ps2_clk), .probe1(raw_keyboard));
    
endmodule