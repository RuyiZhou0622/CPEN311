module T2a_test;
    reg clk, finish_sig, wrent_t2;
    reg [7:0] q, addr_t2, data_t2;
    wire [7:0] addr, data_mem;
    wire wren;
  

    T2a_forloop DUT (.clk(clk), .q(q));
    

    initial begin
        clk =0; #5;
       
        forever begin
        clk = 1;  #5;
        clk = 0; #5;
        end

       
    end
endmodule