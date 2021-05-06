module ToneOrgan (input logic [7:0] SW, 
                  input logic CLOCK_50,
                  input logic [7:0] audio_data,
                  output logic Do_clock,
                  output logic Re_clock,
                  output logic Mi_clock,
                  output logic Fa_clock,
                  output logic So_clock,
                  output logic La_clock,
                  output logic Si_clock,
                  output logic Do2_clock, 
                  output logic oneHz,
                  output logic Sample_Clk_Signal,
                  output logic [31:0] scope_infoASig,
                  output logic [15:0] line2 );


        //number
                parameter character_2 =8'h32;

        //Uppercase Letters
                parameter character_C =8'h43;
                parameter character_D =8'h44;
                parameter character_E =8'h45;
                parameter character_F =8'h46;
                parameter character_S =8'h53;
                parameter character_L =8'h4C;
                parameter character_M =8'h4D;
                parameter character_N =8'h4E;
                parameter character_P =8'h50;
                parameter character_R =8'h52;

        //Lowercase Letters
                parameter character_lowercase_a= 8'h61;
                parameter character_lowercase_e= 8'h65;
                parameter character_lowercase_i= 8'h69;
                parameter character_lowercase_o= 8'h6F;
                parameter character_space= 8'h20; 

//We have the input frequency 50 MHz. To get counters of Do, Re, Mi, Fa, So, La, Si and do,
// we use the input frequency divided by the corresponding frequency.

//instance of the clockdivider module
clockdivider optimal (.clkin(CLOCK_50), 
                      .Do(Do_clock), 
                      .Re(Re_clock), 
                      .Mi(Mi_clock), 
                      .Fa(Fa_clock), 
                      .So(So_clock), 
                      .La(La_clock), 
                      .Si(Si_clock), 
                      .Do2(Do2_clock),
                      .oneHz(oneHz));

always @ (*) begin
  case (SW[3:0])
        4'b0001: begin  //Do
                Sample_Clk_Signal=Do_clock; //generate Do
                scope_infoASig = {character_space, character_D, character_lowercase_o, character_space}; //display Do in channel A     
                line2 = {audio_data, SW[7:0]}; //display the audio_data and the states of the switches information in line2 in the SignalTap.

        end
        4'b0011: begin  //Re
                Sample_Clk_Signal=Re_clock; //generate Re
                scope_infoASig = {character_space, character_R, character_lowercase_e, character_space}; //display Re in channel A
                line2 = {audio_data, SW[7:0]}; //display the audio_data and the states of the switches information in line2 in the SignalTap.
        end
        4'b0101: begin  //Mi
                Sample_Clk_Signal=Mi_clock; //generate Mi
                scope_infoASig = {character_space, character_M, character_lowercase_i, character_space}; //display Mi in channel A
                line2 = {audio_data, SW[7:0]}; //display the audio_data and the states of the switches information in line2 in the SignalTap.
        end
        4'b0111: begin  //Fa
                Sample_Clk_Signal=Fa_clock; //generate Fa
                scope_infoASig = {character_space, character_F, character_lowercase_a, character_space}; //display Fa in channel A
                line2 = {audio_data, SW[7:0]}; //display the audio_data and the states of the switches information in line2 in the SignalTap.
        end
        4'b1001: begin  //So
                Sample_Clk_Signal=So_clock; //generate So
                scope_infoASig = {character_space, character_S, character_lowercase_o, character_space}; //display So in channel A
                line2 = {audio_data, SW[7:0]}; //display the audio_data and the states of the switches information in line2 in the SignalTap.
        end
        4'b1011: begin  //La
                Sample_Clk_Signal=La_clock; //generate La
                scope_infoASig = {character_space, character_L, character_lowercase_a, character_space}; //display La in channel A
                line2 = {audio_data, SW[7:0]}; //display the audio_data and the states of the switches information in line2 in the SignalTap.
        end
        4'b1101: begin  //Si
                Sample_Clk_Signal=Si_clock; //generate Si
                scope_infoASig = {character_space, character_S, character_lowercase_i, character_space}; //display Si in channel A
                line2 = {audio_data, SW[7:0]}; //display the audio_data and the states of the switches information in line2 in the SignalTap.
        end
        4'b1111: begin  //Do2
                Sample_Clk_Signal=Do2_clock; //generate Do2
                scope_infoASig = {character_space, character_D, character_lowercase_o, character_2}; //display Do2 in channel A
                line2 = {audio_data, SW[7:0]}; //display the audio_data and the states of the switches information in line2 in the SignalTap.
        end

           default:begin 
                Sample_Clk_Signal = 0;
                scope_infoASig = {character_C, character_P, character_E, character_N}; //display something insteresting in channel A. (CPEN)
                line2 = {audio_data, SW[7:0]}; //display the default information in line2 in the SignalTap.
           end
  endcase
  
end


endmodule