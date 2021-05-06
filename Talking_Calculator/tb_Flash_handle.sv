module tb_Flash_handle;

    reg syncclk22K, clk50M, done_signal;
    reg [31:0] flash_mem_readdata;
    reg [23:0] start_address, end_address;
    reg [7:0] done;
    reg silent;


    wire flash_mem_read;
    wire [22:0] address;
    wire [7:0] audio_out;
    wire interrupt;
    wire [7:0] start;


    Flash_handle DUT (.syncclk72 (syncclk22K),
                      .clk50M (clk50M),
                      .start_address (start_address),
                      .end_address (end_address),
                      .done_signal (done_signal),
                      .done (done),
                      .silent (silent),
                      .address (address),
                      .flash_mem_read (flash_mem_read),
                      .flash_mem_readdata (flash_mem_readdata),
                      .audio_out (audio_out),
                      .interrupt (interrupt),
                      .start(start)
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

       
        start_address = 24'b00000000_00000000_11111111; end_address = 24'b00000000_00000001_11111111;  
        silent = 0;
        done = 1'b1; done_signal = 1'b1; flash_mem_readdata = 32'b10101010_00000000_11111111_00000000; 
        #2000;

        done = 1'b1; done_signal = 1'b1;  flash_mem_readdata = 32'b10101010_00000000_11111111_00000000; 
        #2000;
        silent = 1'b1;
        done = 1'b1; done_signal = 1'b1;  flash_mem_readdata = 32'b10101010_00000000_11111111_00000000; 
        #2000;
        done = 1'b1; done_signal = 1'b1;  flash_mem_readdata = 32'b10101010_00000000_11111111_00000000;
        #2000;
        done = 1'b1; done_signal = 1'b1;  flash_mem_readdata = 32'b10101010_00000000_11111111_00000000;
        #2000;
        done = 1'b1; done_signal = 1'b1;  flash_mem_readdata = 32'b10101010_00000000_11111111_00000000;
        #2000;
        
        done = 1'b1; done_signal = 1'b1;  flash_mem_readdata = 32'b10101010_00000000_11111111_00000000;
        #2000;
       done = 1'b1; done_signal = 1'b1;  flash_mem_readdata = 32'b10101010_00000000_11111111_00000000;
        #2000;
        done= 1'b1; done_signal = 1'b1;  flash_mem_readdata = 32'b10101010_00000000_11111111_00000000;
        #2000;
        done = 1'b1; done_signal = 1'b1;  flash_mem_readdata = 32'b10101010_00000000_11111111_00000000;
        #2000;
        done = 1'b1; done_signal = 1'b1;  flash_mem_readdata = 32'b10101010_00000000_11111111_00000000;
        #2000;
        done = 1'b1; done_signal = 1'b1;  flash_mem_readdata = 32'b10101010_00000000_11111111_00000000;
        #2000;
        done = 1'b1; done_signal = 1'b1;  flash_mem_readdata = 32'b10101010_00000000_11111111_00000000;
        #2000;

        done = 1'b1; done_signal = 1'b1;  flash_mem_readdata = 32'b10101010_00000000_11111111_00000000;
        #2000;
    end
endmodule