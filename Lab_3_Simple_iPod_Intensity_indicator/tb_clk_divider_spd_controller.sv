module tb_clk_divider_spd_controller;
    reg clkin, speedup, speeddown, speedrst;
    wire clkout;

    clk_divider_spd_controller DUT (.clkin(clkin), 
                      .clkout (clkout), 
                      .speedup (speedup), 
                      .speeddown (speeddown), 
                      .speedrst (speedrst)
                      );

    initial begin
        clkin = 1'b1;
        #5;
        forever begin
        clkin = 1'b0;
        #5;
        clkin = 1'b1;
        #5;
        end
    end

    initial begin
        speedup = 0; speeddown = 0; speedrst = 0;
        #50000;

        speedup = 1; speeddown = 0; speedrst = 0;
        #30000;

        speedup = 0; speeddown = 0; speedrst = 0;
        #30000;

        speedup = 0; speeddown = 0; speedrst = 1;
        #10000;

        speedup = 0; speeddown = 1; speedrst = 0;
        #30000;

        speedup = 0; speeddown = 0; speedrst = 1;
        #1000;

        speedup = 0; speeddown = 0; speedrst = 0;
        #10000;
        $stop;
    end

endmodule