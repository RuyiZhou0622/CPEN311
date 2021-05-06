module tb_Read_Data;
    reg clk,
        flash_mem_waitrequest,
        flash_mem_readdatavalid,
        flash_mem_read;

    wire done_signal;

    Read_Data DUT (.clk50M (clk),
                   .flash_mem_waitrequest (flash_mem_waitrequest),
                   .flash_mem_readdatavalid (flash_mem_readdatavalid),
                   .flash_mem_read (flash_mem_read),
                   .done_signal (done_signal)
                  );

    initial begin
        clk = 1'b1; #5;
        forever begin
            clk = 1'b0; #5;
            clk = 1'b1; #5;
        end
                    
    end

    initial begin

        flash_mem_read = 0; flash_mem_waitrequest = 0;  flash_mem_readdatavalid = 0;
        #10;

        flash_mem_read = 1; flash_mem_waitrequest = 0;  flash_mem_readdatavalid = 0;
        #10;

        flash_mem_read = 0; flash_mem_waitrequest = 1;  flash_mem_readdatavalid = 0; 
        #10;

        flash_mem_read = 0; flash_mem_waitrequest = 0;  flash_mem_readdatavalid = 0; 
        #10;

        flash_mem_read = 0; flash_mem_waitrequest = 0;  flash_mem_readdatavalid = 1; 
        #10;
 
        flash_mem_read = 0; flash_mem_waitrequest = 0;  flash_mem_readdatavalid = 0;
        #10;

        flash_mem_read = 0; flash_mem_waitrequest = 0;  flash_mem_readdatavalid = 0;
        #10;
        $stop;
    end
endmodule