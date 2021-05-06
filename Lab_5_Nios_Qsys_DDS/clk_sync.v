module clk_sync(clk1, clk2, datain, dataout);
	parameter m = 12;
	input clk1, clk2;
	input [m-1:0] datain;
	output reg [m-1:0] dataout;

	reg [m-1:0] int2, int3;
	reg clk2int1;
	reg enable;
	reg prev_enable = 1'b0;
	
	always@(posedge clk1)
		begin
			int2 <= datain;
			if ((enable != prev_enable) && (~enable)) int3 <= int2;
			prev_enable <= enable;
		end
	
	always@(posedge ~clk1)
		begin
			clk2int1 <= clk2;
			enable <= clk2int1;
		end
	always@(posedge clk2)
		begin
			dataout <= int3;
		end
	

endmodule
