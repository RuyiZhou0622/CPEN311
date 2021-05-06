module testbench_LED;
    reg frequency; 
    wire [7:0] LED;

    flashLEDs DUT (.frequency(frequency), .LED(LED));

    initial begin
        frequency = 1'b0;
        #10;
        forever begin
            frequency = 1'b1;
            #10;
            frequency = 1'b0;
            #10;
            
        end     
  
    end   
endmodule