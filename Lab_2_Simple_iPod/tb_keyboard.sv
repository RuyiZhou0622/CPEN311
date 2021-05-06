module tb_keyboard;

    reg clk50M;
    reg [7:0] kbd_input; 

    wire kbd_start, direction;

    parameter character_B =8'h42;
    parameter character_D =8'h44;
    parameter character_E =8'h45;
    parameter character_F =8'h46;

    parameter character_lowercase_b= 8'h62;
    parameter character_lowercase_d= 8'h64;
    parameter character_lowercase_e= 8'h65;
    parameter character_lowercase_f= 8'h66;

    keyboard DUT (.clk50M (clk50M),
                  .kbd_input (kbd_input),
                  .kbd_start (kbd_start),
                  .direction (direction)
                  );

    initial begin
            clk50M = 1'b0; 
            #1;
        forever begin
            clk50M = 1'b1; 
            #1;
            clk50M = 1'b0; 
            #1;
        end
    end

    initial begin
        kbd_input = character_E; 
        #10;

        kbd_input = character_D; 
        #10;

        kbd_input = character_lowercase_e; 
        #10;

        kbd_input = character_B; 
        #10;

        kbd_input = character_D; 
        #10;

        kbd_input = character_E; 
        #10;

        kbd_input = character_F; 
        #10;

        kbd_input = character_D; 
        #10;
        
        $stop;
    end

endmodule