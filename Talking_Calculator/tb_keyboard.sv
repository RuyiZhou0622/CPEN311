module tb_keyboard;

    reg clk50M;
    reg [7:0] kbd_input; 
    reg [7:0] equal_done;

    wire [7:0] select_key;
    wire [7:0] check_equal;
 
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

    keyboard DUT (.clk50M (clk50M),
                  .kbd_input (kbd_input),
                  .select_key (select_key),
                  .equal_done (equal_done),
                  .check_equal (check_equal)
                  );

    initial begin
            clk50M = 1'b0; 
            #2;
        forever begin
            clk50M = 1'b1; 
            #2;
            clk50M = 1'b0; 
            #2;
        end
    end

    initial begin
        equal_done = 8'b0; 
        kbd_input = character_5; 
        #10; //2

        kbd_input = character_plus; 
        #10; //2

        kbd_input = character_5; 
        #10; //3

        kbd_input = character_equals; 
        #10;

        equal_done = 8'b1; 
        #10;
        equal_done = 8'b0; 
        #10;

        kbd_input = character_5; 
        #10;

    
        kbd_input = character_minus; 
        #10;

        kbd_input = character_plus; 
        #10;

        kbd_input = character_9; 
        #10;

        kbd_input = character_equals; 
        #10;

        equal_done = 8'b1; 
        #10;
        equal_done = 8'b0; 
        #10;
        
        
    end

endmodule