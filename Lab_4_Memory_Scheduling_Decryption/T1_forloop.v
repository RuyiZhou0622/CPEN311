module T1_forloop (clk, addr, data_mem, wren, finish_sig);

    input clk;
    output [7:0] addr;
    output [7:0] data_mem;
    output wren;
    output finish_sig;

    wire [7:0] data_mem;
    reg [7:0] index = 8'b0; //maximum is 255
    reg finish_sig = 0;
     
    assign data_mem = index;
    assign addr = index;
    assign wren = ~finish_sig;

    always @(posedge clk) begin
        if ((index < 8'b1111_1111) && (finish_sig == 0)) begin  //8'b1111_1111 is d'255
            index <= index + 8'b1;
        end
        else finish_sig = 1'b1;
    end  


    //instance of the s-memory
   // s_memory T1_mem (.address(index),
     //                .clock (clk),
    //                 .data (data_mem),
      //               .wren (~finish_sig),  //write_enable is always 1.
      //               .q (q)
     //                );

endmodule