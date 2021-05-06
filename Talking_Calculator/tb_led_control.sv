module tb_led_control;

    reg clk;
    reg [7:0] audio_data;
    wire [7:0] led_out;

    led_control DUT (.clk(clk), .audio_data(audio_data), .led_out(led_out));

    initial begin
        clk = 0; #5;
        forever begin 
            clk = 1; #5;
            clk = 0; #5;
        end
    end

    initial begin
        audio_data = 8'd10; #10;
        audio_data = - 8'd10; #10;
        audio_data = 8'd10; #10;
        audio_data = - 8'd10; #10;
        audio_data = 8'd10; #5;
    
      
    end
endmodule

