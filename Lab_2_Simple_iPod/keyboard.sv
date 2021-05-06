module keyboard (clk50M, kbd_input, kbd_start, direction);
    input logic clk50M;
    input logic [7:0] kbd_input; 
    output logic kbd_start, direction;

    parameter character_B =8'h42;
    parameter character_D =8'h44;
    parameter character_E =8'h45;
    parameter character_F =8'h46;

    parameter character_lowercase_b= 8'h62;
    parameter character_lowercase_d= 8'h64;
    parameter character_lowercase_e= 8'h65;
    parameter character_lowercase_f= 8'h66;

    logic [4:0] state;
    // kbd_start, direction _ states
    parameter idle     = 5'b00_000,
              forward  = 5'b10_001,
              backward = 5'b11_010,
              pause_F  = 5'b00_011,
              pause_B  = 5'b01_100;
              
    
    always_ff @(posedge clk50M) begin
        case(state)
            idle:
                // press E to start playing music. Before press E, press F to go pauseF state, press B to go to pauseB state
                if ((kbd_input == character_E) || (kbd_input == character_lowercase_e)) state <= forward;
                else if ((kbd_input == character_F) || (kbd_input == character_lowercase_f)) state <= pause_F;
                else if ((kbd_input == character_B) || (kbd_input == character_lowercase_b)) state <= pause_B;
                else state <= idle;

            forward:
                //start to play the music forward. Press B to change the direction
                if ((kbd_input == character_B) || (kbd_input == character_lowercase_b)) state <= backward;
                else if ((kbd_input == character_D) || (kbd_input == character_lowercase_d)) state <= pause_F;
                else state <= forward;

            backward:
                //start to play the music backward. Press F to change the direction
                if ((kbd_input == character_F) || (kbd_input == character_lowercase_f)) state <= forward;
                else if ((kbd_input == character_D) || (kbd_input == character_lowercase_d)) state <= pause_B;
                else state <= backward;

            pause_F:
                // press E to satrt play forward, press B to go pauseB
                if ((kbd_input == character_E) || (kbd_input == character_lowercase_e)) state <= forward;
                else if ((kbd_input == character_B) || (kbd_input == character_lowercase_b)) state <= pause_B;
                else state <= pause_F;

            pause_B:
                // press E to satrt play forward, press F to go pauseF
                if ((kbd_input == character_E) || (kbd_input == character_lowercase_e)) state <= backward;
                else if ((kbd_input == character_F) || (kbd_input == character_lowercase_f)) state <= pause_F;
                else state <= pause_B;
  
            default: state <= idle;
        endcase
    end

    //set the output
    always_ff @(posedge clk50M) begin
        
        kbd_start <= state [4];
        direction <= state [3];

    end
    
endmodule