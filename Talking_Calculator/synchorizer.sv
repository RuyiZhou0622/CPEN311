module synchorizer (async_sig, outclk, out_sync_sig);

	input logic  async_sig, outclk;
	output logic out_sync_sig;
	logic q1,q2,q3;

	FDC fdc_2 (1'b1, async_sig, q3, q1);
	FDC fdc_3 (q1, outclk, 1'b0, q2);
	FDC fdc_4 (q2, outclk, 1'b0, out_sync_sig);
	FDC fdc_1 (out_sync_sig, outclk, 1'b0, q3);

endmodule

module FDC ( d, clk, clr, q);
	input logic d, clk, clr;
	output logic  q;

	always @(posedge clk, posedge clr)
		if (clr)
			q <= 0;
		else 
			q <= d;
endmodule