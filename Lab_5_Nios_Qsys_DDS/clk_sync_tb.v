module clk_sync_tb();
	parameter m = 12;
	reg clk1, clk2;
	reg [m-1:0] datain;
	wire [m-1:0] dataout;

	clk_sync DUT(.clk1(clk1), .clk2(clk2), .datain(datain), .dataout(dataout));

	initial
		begin
			clk2 = 0;
			datain = 0;
			forever
				begin
					repeat(5)
						begin
							clk1 = 1; #5;
							clk1 = 0; #5;
							datain = datain + 1;
						end
					clk2 = ~clk2;
					datain = datain + 1;
				end

		end
endmodule
