module testbench_divider;
    reg clkin;
    wire Do;
    wire Re;
    wire Mi;
    wire Fa;
    wire So;
    wire La;
    wire Si;
    wire Do2;
    wire oneHz;

    parameter divider_Do = 32'd95602;
    parameter divider_Re = 32'd85179;
    parameter divider_Mi = 32'd75873;
    parameter divider_Fa = 32'd71633;
    parameter divider_So = 32'd63857;
    parameter divider_La = 32'd56818;
    parameter divider_Si = 32'd50659;
    parameter divider_Do2 = 32'd47801;
    parameter divider_oneHz = 32'd50000000;

    clockdivider dut (.clkin(clkin), 
                      .Do(Do), 
                      .Re(Re), 
                      .Mi(Mi), 
                      .Fa(Fa), 
                      .So(So), 
                      .La(La), 
                      .Si(Si), 
                      .Do2(Do2),
                      .oneHz(oneHz));

    initial begin
        clkin = 1'b1;
        #1;

        forever begin
            clkin = 1'b0;
            #1;
            clkin = 1'b1;
            #1;
        end
           
    end   
endmodule