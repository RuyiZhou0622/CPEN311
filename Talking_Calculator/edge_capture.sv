module edge_capture (clk, in_sig, out_sig);

    input logic clk;
    input logic in_sig;
    output logic out_sig;

    logic delay_in_sig;
    logic reverse_sig;

    //make a delay 1 clk signal
    always_ff@(posedge clk) begin
        delay_in_sig <= in_sig;
    end

    //reverse the delay signal
    assign #2 reverse_sig = ~delay_in_sig;

    //compare the input signal and the reverse delay signal
    //and caputure the posedge
    assign out_sig = in_sig & reverse_sig;

endmodule