module tb_Flash_handle;

    reg syncclk22K, clk50M, direction, done_signal, kbd_start;
    reg [31:0] flash_mem_readdata;

    wire flash_mem_read;
    wire [22:0] address;
    wire [7:0] audio_out;

    Flash_handle DUT (.syncclk22K (syncclk22K),
                      .clk50M (clk50M),
                      .direction (direction),
                      .done_signal (done_signal),
                      .kbd_start (kbd_start),
                      .address (address),
                      .flash_mem_read (flash_mem_read),
                      .flash_mem_readdata (flash_mem_readdata),
                      .audio_out (audio_out)
                      );

    initial begin
        clk50M = 1'b1; #1;
        forever begin
            clk50M =1'b0; #1;
            clk50M =1'b1; #1;
        end
    end

    initial begin
            syncclk22K = 1'b1; #1000;
        forever begin
            syncclk22K = 1'b0; #1000;
            syncclk22K = 1'b1; #1000;
        end
    end

    initial begin

        kbd_start = 1'b0; done_signal = 1'b0; direction = 1'b0; flash_mem_readdata = 32'b10101010_00000000_11111111_00000000; 
        #5000;

        kbd_start = 1'b1; done_signal = 1'b0; direction = 1'b0; flash_mem_readdata = 32'b10101010_00000000_11111111_00000000; 
        #5000;

        kbd_start = 1'b0; done_signal = 1'b1; direction = 1'b0; flash_mem_readdata = 32'b10101010_00000000_11111111_00000000; 
        #5000;

        kbd_start = 1'b0; done_signal = 1'b1; direction = 1'b0; flash_mem_readdata = 32'b10101010_00000000_11111111_00000000; 
        #5000;
        kbd_start = 1'b0; done_signal = 1'b0; direction = 1'b0; flash_mem_readdata = 32'b10101010_00000000_11111111_00000000;
        #5000;
        kbd_start = 1'b0; done_signal = 1'b0; direction = 1'b0; flash_mem_readdata = 32'b10101010_00000000_11111111_00000000;
        #5000;
        kbd_start = 1'b0; done_signal = 1'b0; direction = 1'b0; flash_mem_readdata = 32'b10101010_00000000_11111111_00000000;
        #5000;

        kbd_start = 1'b0; done_signal = 1'b0; direction = 1'b1; flash_mem_readdata = 32'b10101010_00000000_11111111_00000000;
        #5000;
        kbd_start = 1'b0; done_signal = 1'b0; direction = 1'b1; flash_mem_readdata = 32'b10101010_00000000_11111111_00000000;
        #5000;
        kbd_start = 1'b0; done_signal = 1'b0; direction = 1'b1; flash_mem_readdata = 32'b10101010_00000000_11111111_00000000;
        #5000;
        kbd_start = 1'b0; done_signal = 1'b0; direction = 1'b1; flash_mem_readdata = 32'b10101010_00000000_11111111_00000000;
        #5000;
    end
endmodule