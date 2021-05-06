module tb_edge_capture;
    reg clk, in_sig;
    wire out_sig;

    edge_capture DUT (.clk(clk), .in_sig(in_sig), .out_sig(out_sig));

    initial begin
        clk = 1'b0; #1;
        forever begin
            clk =1'b1; #1;
            clk =1'b0; #1;
        end
    end

    initial begin
            in_sig = 1'b0; #10;
        forever begin
            in_sig  = 1'b1; #10;
            in_sig  = 1'b0; #10;
        end
    end
endmodule