module linear_feedback_shift_register(clk, lfsr);
	input clk;
	output [4:0] lfsr;
	
	parameter [4:0] ONE = 5'd1;
	parameter ON = 1'd1;
	reg [4:0] lfsr;

	reg startflag = ~ON;

	always_ff@(posedge clk)
		begin
		if (~startflag)
			begin
				lfsr <= ONE;
				startflag <= ON;
			end

		else
			begin
				lfsr[3] <= lfsr[4]; lfsr[2] <= lfsr[3]; lfsr[1] <= lfsr[2]; lfsr[0] <= lfsr[1]; lfsr[4] <= lfsr[0] ^ lfsr[2];
			end
		end
endmodule
