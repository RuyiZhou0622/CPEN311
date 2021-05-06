module flashLEDs (input logic frequency, output logic [7:0] LED);


logic right_to_left;

//assign right_to_left = 1'b1;

always @(posedge frequency) begin

        case({right_to_left,LED[7:0]})
                9'b100000000:begin
                        LED [7:0] = 8'b00000001;
                end 
                9'b100000001:begin
                        LED [7:0] = 8'b00000010;
                end 
                9'b100000010:begin
                        LED [7:0] = 8'b00000100;
                end 
                9'b100000100:begin
                        LED [7:0] = 8'b00001000;
                end 
                9'b100001000:begin
                        LED [7:0] = 8'b00010000;
                end 
                9'b100010000:begin
                        LED [7:0] = 8'b00100000;
                end 
                9'b100100000:begin
                        LED [7:0] = 8'b01000000;
                end 
                9'b101000000:begin
                        LED [7:0] = 8'b10000000;
                        right_to_left = 1'b0;
                end 
                /////from left to right
                9'b010000000:begin
                        LED [7:0] = 8'b01000000;
                end
                9'b001000000:begin
                        LED [7:0] = 8'b00100000;
                end
                9'b000100000:begin
                        LED [7:0] = 8'b00010000;
                end
                9'b000010000:begin
                        LED [7:0] = 8'b00001000;
                end 
                9'b000001000:begin
                        LED [7:0] = 8'b00000100;
                end 
                9'b000000100:begin
                        LED [7:0] = 8'b00000010;
                end 
                9'b000000010:begin
                        LED [7:0] = 8'b00000001;
                        right_to_left = 1'b1;
                end 
               
              
                default: {right_to_left,LED[7:0]} = 9'b100000000;
        endcase
end

endmodule