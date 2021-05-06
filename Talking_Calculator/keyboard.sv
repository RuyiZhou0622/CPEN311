module keyboard (clk50M, kbd_input, select_key, check_equal, equal_done);
    input logic clk50M;
    input logic [7:0] kbd_input;
    input logic [7:0] equal_done; 
   // input logic [7:0] pico_done;
    output logic [7:0] select_key;
   // output logic [4:0] state;
    output logic [7:0] check_equal;
  //  output logic [7:0] start_pico;

   //numbers
    parameter character_0 =8'h30;
    parameter character_1 =8'h31;
    parameter character_2 =8'h32;
    parameter character_3 =8'h33;
    parameter character_4 =8'h34;
    parameter character_5 =8'h35;
    parameter character_6 =8'h36;
    parameter character_7 =8'h37;
    parameter character_8 =8'h38;
    parameter character_9 =8'h39;
    //sign
    parameter character_minus = 8'h2D;         //'-'
    parameter character_plus = 8'h2B;          //'+'
    parameter character_equals = 8'h3D;         //'='

    logic [5:0] state;
    logic [7:0] num_1, num_2;
    logic [7:0] sign, result;


    parameter idle     = 6'h00,
              second   = 6'h01,
              third    = 6'h02,
              fourth   = 6'h03,
              done     = 6'h04,
              out_error_1 = 6'h05,
              out_error_2 = 6'h06,
              out_error_3 = 6'h07,
              out_error_4 = 6'h08,
              idle_out    = 6'h09,
              second_out = 6'h0A,
              third_out  = 6'h0B,
              fourth_out = 6'h0C,
              done_out   = 6'h0D,
              wait_1     = 6'h0E,
              //error state
              out_error_1_plus = 6'h13,
              out_error_1_minus = 6'h14,
              out_error_1_equals = 6'h15,
              out_error_3_plus = 6'h16,
              out_error_3_minus = 6'h17,
              out_error_3_equals = 6'h18,
              out_error_2_0 = 6'h19,
              out_error_2_1 = 6'h1A,
              out_error_2_2 = 6'h1B,
              out_error_2_3 = 6'h1C,
              out_error_2_4 = 6'h1D,
              out_error_2_5 = 6'h1E,
              out_error_2_6 = 6'h1F,
              out_error_2_7 = 6'h20,
              out_error_2_8 = 6'h21,
              out_error_2_9 = 6'h22,
              out_error_2_equals = 6'h23,
              out_error_4_0 = 6'h24,
              out_error_4_1 = 6'h25,
              out_error_4_2 = 6'h26,
              out_error_4_3 = 6'h27,
              out_error_4_4 = 6'h28,
              out_error_4_5 = 6'h29,
              out_error_4_6 = 6'h2A,
              out_error_4_7 = 6'h2B,
              out_error_4_8 = 6'h2C,
              out_error_4_9 = 6'h2D,
              out_error_4_minus = 6'h2E,
              out_error_4_plus = 6'h2F;



    always_ff @(posedge clk50M) begin
        case(state)
///////////////////////////////////Input the first number//////////////////////
            idle: begin 
                if(kbd_input != character_equals) begin

                    if((kbd_input == character_0)||(kbd_input == character_1)||(kbd_input == character_2)||
                        (kbd_input == character_3)||(kbd_input == character_4)||(kbd_input == character_5)||
                        (kbd_input == character_6)||(kbd_input == character_7)||(kbd_input == character_8)||
                        (kbd_input == character_9)) begin
                            num_1 <= kbd_input - 8'h30;
                            select_key <= kbd_input;
                            state <= idle_out;
                    end
                    else if (kbd_input == character_plus) begin
                        state <= out_error_1_plus;
                    end

                    else if (kbd_input == character_minus) begin
                        state <= out_error_1_minus;
                    end
                   
                    else begin
                        state <= idle;
                    end
                
                end 
                else if ((kbd_input == character_equals)&&(result == 0)) begin 
                    state <= out_error_1_equals;
                end
               
                else begin state <= idle; end
            end

            idle_out: begin
                   
                    state <= second;
              
            end
///////////////////////////////////Input the sign//////////////////////
            second: begin 
              
                if(kbd_input != select_key) begin
                    if(kbd_input == character_0) begin                    
                        state <= out_error_2_0;           
                    end else if (kbd_input == character_1) begin
                        state <= out_error_2_1;
                    end else if (kbd_input == character_2) begin
                        state <= out_error_2_2;
                    end else if (kbd_input == character_3) begin
                        state <= out_error_2_3;
                    end else if (kbd_input == character_4) begin
                        state <= out_error_2_4;
                    end else if (kbd_input == character_5) begin
                        state <= out_error_2_5;
                    end else if (kbd_input == character_6) begin
                        state <= out_error_2_6;
                    end else if (kbd_input == character_7) begin
                        state <= out_error_2_7;
                    end else if (kbd_input == character_8) begin
                        state <= out_error_2_8;
                    end else if (kbd_input == character_9) begin
                        state <= out_error_2_9;
                    end else if (kbd_input == character_equals) begin
                        state <= out_error_2_equals;
                    end
                    else if ((kbd_input == character_minus)||(kbd_input == character_plus)) begin
                        select_key <= kbd_input;
                        sign <= kbd_input;
                        state <= second_out;
                    end
                    else begin
                    state <= second;
                    end 
                end
                else begin 
                
                    state <= second; end
            end

            second_out: begin
           
                state <= third;
          
            end
///////////////////////////////////Input the second number//////////////////////
            third:begin 
             
                if(kbd_input != select_key) begin
                    if((kbd_input == character_0)||(kbd_input == character_1)||(kbd_input == character_2)||
                        (kbd_input == character_3)||(kbd_input == character_4)||(kbd_input == character_5)||
                        (kbd_input == character_6)||(kbd_input == character_7)||(kbd_input == character_8)||
                        (kbd_input == character_9)) begin
                            num_2 <= kbd_input - 8'h30;
                            select_key <= kbd_input;
                            state <= third_out;
                    end

                    else if (kbd_input == character_minus) begin
                    
                        state <= out_error_3_minus;
                  
                    end
                    else if (kbd_input == character_plus) begin
                        state <= out_error_3_plus;
                    end
                    else if (kbd_input == character_equals) begin
                        state <= out_error_3_equals;
                    end
                    else begin
                        state <= third;
                    end 
                end
                else begin 
                    state <= third; end
            end

            third_out: begin
              
                    state <= fourth;
            
                
            end
///////////////////////////////////Input the equal sign//////////////////////
            fourth:begin  
            
                if(kbd_input != select_key) begin
                    if((kbd_input == character_equals)) begin
                        check_equal <= 8'b0000_0001;
               
                        select_key <= kbd_input;
                        state <= fourth_out;
                      
                    end
                    else if (kbd_input == character_0) begin
                         state <= out_error_4_0;       
                    end else if (kbd_input == character_1) begin
                        state <= out_error_4_1;
                    end else if (kbd_input == character_2) begin
                        state <= out_error_4_2;
                    end else if (kbd_input == character_3) begin
                        state <= out_error_4_3;
                    end else if (kbd_input == character_4) begin
                        state <= out_error_4_4;
                    end else if (kbd_input == character_5) begin
                        state <= out_error_4_5;
                    end else if (kbd_input == character_6) begin
                        state <= out_error_4_6;
                    end else if (kbd_input == character_7) begin
                        state <= out_error_4_7;
                    end else if (kbd_input == character_8) begin
                        state <= out_error_4_8;
                    end else if (kbd_input == character_9) begin
                        state <= out_error_4_9;
                    end else if (kbd_input == character_minus) begin
                        state <= out_error_4_minus;
                    end else if (kbd_input == character_plus) begin
                        state <= out_error_4_plus;
                    end
                    else begin
                        state <= fourth;
                    end
                end
                else begin 
                    state <= fourth; end
            end

            
            fourth_out: begin
            
                    if (equal_done == 8'b0000_0001) begin
                        check_equal <= 8'b0;
                        state <= done;
                    end else begin
                        state <= fourth_out;
                    end
            
            end

            done: begin
             
                if(select_key == character_equals) begin
                    if(sign == character_plus) begin
                        if(num_1+num_2 < 10) begin
                            result <= num_1 + num_2 + 8'h20;
                        end else begin
                        result <= num_1 + num_2 + 8'h60;
                        end
                        state <= wait_1;
                    end
                    else begin //sign is minus
                        if(num_1>=num_2) begin
                            if (num_1-num_2 < 10) begin
                                result <= num_1 - num_2 + 8'h20;
                            end else begin
                                result <= num_1 - num_2 + 8'h60;
                            end
                        end else begin //deal with the negative result
                            result <= num_2 - num_1 + 8'h40;
                        end
                        state <= wait_1;
                    end
                    
                end
                else begin state <= done; end
            end

            wait_1: begin
             
                state <= done_out;
            
            end
            done_out: begin
               
                select_key <= result;
                state <= idle;

            end

////////error for state idle (input number 1)//////
            out_error_1_equals: begin
                select_key <= 8'h81;
                state <= idle;
            end
            out_error_1_minus: begin
                select_key <= 8'h82;
                state <= idle;
            end
            out_error_1_plus: begin
                select_key <= 8'h83;
                state <= idle;
            end
//////////////////////////////////////////////////
            out_error_2_0: begin
                select_key <= 8'h81;
                state <= second;
            end
            out_error_2_1: begin
                select_key <= 8'h82;
                state <= second;
            end
            out_error_2_2: begin
                select_key <= 8'h83;
                state <= second;
            end
            out_error_2_3: begin
                select_key <= 8'h84;
                state <= second;
            end
            out_error_2_4: begin
                select_key <= 8'h85;
                state <= second;
            end
            out_error_2_5: begin
                select_key <= 8'h86;
                state <= second;
            end
            out_error_2_6: begin
                select_key <= 8'h87;
                state <= second;
            end
            out_error_2_7: begin
                select_key <= 8'h88;
                state <= second;
            end
            out_error_2_8: begin
                select_key <= 8'h89;
                state <= second;
            end
            out_error_2_9: begin
                select_key <= 8'h8A;
                state <= second;
            end
            out_error_2_equals: begin
                select_key <= 8'h8B;
                state <= second;
            end
////////error for state third (input number 2)//////
            out_error_3_equals: begin
               // select_key <= 8'h84;
                select_key <= 8'h81;
                state <= third;
            end

            out_error_3_minus: begin
               // select_key <= 8'h85;
                select_key <= 8'h82;
                state <= third;
            end

            out_error_3_plus: begin
               // select_key <= 8'h86;
                select_key <= 8'h83;
                state <= third;
            end
////////////error for the fourth state (input euqal sign) ////////////////////////////////////////
            out_error_4_0: begin
                select_key <= 8'h81;
                state <= fourth;
            end
            out_error_4_1: begin
                select_key <= 8'h82;
                state <= fourth;
            end
            out_error_4_2: begin
                select_key <= 8'h83;
                state <= fourth;
            end
            out_error_4_3: begin
                select_key <= 8'h84;
                state <= fourth;
            end
            out_error_4_4: begin
                select_key <= 8'h85;
                state <= fourth;
            end
            out_error_4_5: begin
                select_key <= 8'h86;
                state <= fourth;
            end
            out_error_4_6: begin
                select_key <= 8'h87;
                state <= fourth;
            end
            out_error_4_7: begin
                select_key <= 8'h88;
                state <= fourth;
            end
            out_error_4_8: begin
                select_key <= 8'h89;
                state <= fourth;
            end
            out_error_4_9: begin
                select_key <= 8'h8A;
                state <= fourth;
            end
            out_error_4_minus: begin
                select_key <= 8'h8B;
                state <= fourth;
            end
            out_error_4_plus: begin
                select_key <= 8'h8C;
                state <= fourth;
            end
          
///////////////////////////////////////////////////////////////////////////////////
            default: begin 
                state <= idle;
                select_key <= 8'hFF;
                result <= 8'h0;
                num_1 <= 0;
                num_2 <= 0;
                sign <= 0;
                check_equal <= 8'b0;
                
            end
        endcase
    end
              
    
endmodule