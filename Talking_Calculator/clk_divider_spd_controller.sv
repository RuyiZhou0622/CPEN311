module clk_divider_spd_controller (clkin, clkout,speedup,speeddown,speedrst);
      
    input logic clkin, speedup, speeddown, speedrst;
    output logic clkout;
    
    parameter divisor_22k = 32'd5610;
    parameter spd_up      = 3'b100,
              spd_down    = 3'b010,
              spd_rst     = 3'b001,
              no_change   = 3'b000;

    logic [31:0] count = 32'b0;
    logic compare;
    logic [31:0] divisor = divisor_22k;

    //assign control = {speedup, speeddown, speedrst};
    //Generate the frequency 
    always_ff @(posedge clkin) begin
        //control the frequency according to the state of the KEYs
        case({speedup, speeddown, speedrst})
            spd_up:
                    if (divisor <= 32'd20 ) divisor = 32'd20;
                    else divisor <= divisor - 32'd2;
            spd_down: 
                    if (divisor >= 32'd13632) divisor = 32'd13632;
                    else divisor <= divisor + 32'd2;
            spd_rst: 
                    divisor <= divisor_22k;
         
            default: divisor <= divisor;
        endcase
    end 

    always_ff @(posedge clkin) begin
         //Check if the counter is greater than the HALF of the divbisor
        //The divisor is halfed because the clcok has 2 output values: 1 and 0.

        compare <= (count < (divisor/2));
        
        count <= count + 1; //start to count the number

        //If the count is added to equal the divisor. Start to re_count from 0.
        if(count>=(divisor -1))begin
            count <= 0;
        end

        // Seperate the time to 2 equal amount. 
        // One of them outputs the value 1.
        // The other one outputs the value 0.
         case (compare) 
            1'b1: begin
                clkout <=1'b1;
            end
            1'b0: begin
                clkout <=1'b0;
            end
            default: compare <= 1'b0;
        endcase
        
    end
    
endmodule

