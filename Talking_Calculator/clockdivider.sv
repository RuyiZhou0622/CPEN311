
module clockdivider (clkin,
                     clkout);

    input logic clkin;
    output logic clkout;
  
    parameter divider_oneHz = 32'd6944;


    logic [31:0] count_oneHz = 32'b0;
    logic compare_oneHz;
    
    //Generate the frequency of Do
    always @ (posedge clkin) begin

        //Check if the counter is greater than the HALF of the divbisor
        //The divisor is halfed because the clcok has 2 output values: 1 and 0.
        //Generate the frequency of oneHz
        compare_oneHz = (count_oneHz < (divider_oneHz/2));
        count_oneHz <= count_oneHz + 1;

        if(count_oneHz==(divider_oneHz -1))begin
            count_oneHz <= 0;
        end

         case (compare_oneHz) 
            1'b1: begin
                clkout <=1'b1;
            end
            1'b0: begin
                clkout <=1'b0;
            end
            default: compare_oneHz <= 1'b0;
        endcase
        
    end

endmodule

