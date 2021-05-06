module tb_sync;
    reg async_sig, outclk;
    wire out_sync_sig;

    synchorizer DUT (async_sig, outclk, out_sync_sig);

    always
    begin
	outclk = 1; #5; 
	outclk = 0; #5;
    end
initial begin
    async_sig = 0; #203;
    async_sig = 1; 
end
endmodule