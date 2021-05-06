module T1_test;
    reg clk;
    wire [7:0] addr, data_mem;
    wire wren, finish_sig;

    T1_forloop DUT (clk, addr, data_mem, wren, finish_sig);

    initial begin
        clk = 1; #5;
        forever begin
        clk = 0; #5;
        clk = 1; #5;
        end
      
    end
endmodule