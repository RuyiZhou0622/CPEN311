module dds_tb();

	reg clk, reset;
	wire unsigned [11:0] sin_out, cos_out, squ_out, saw_out;

	waveform_gen DUT(.clk(clk), .reset(reset), .en(1'b1), .phase_inc(32'd171800), .sin_out(sin_out), .cos_out(cos_out), .squ_out(squ_out), .saw_out(saw_out));


	initial
		begin

			reset = 1'b0; #10;
			clk = 1; #5;
			clk = 0; #5;
			reset = 1'b1; #10;
			
			forever
				begin
					clk = 1; #5;
					clk = 0; #5;

				end

		end

endmodule
