module testbench_ToneOrgan;
    reg  [7:0] SW;
    reg  CLOCK_50;
    reg  [7:0] audio_data;
    wire Sample_Clk_Signal;
    wire [31:0] scope_infoASig;
    wire [15:0] line2 ;
    wire Do_clock;
    wire Re_clock;
    wire Mi_clock;
    wire Fa_clock;
    wire So_clock;
    wire La_clock;
    wire Si_clock;
    wire Do2_clock;


    ToneOrgan DUT ( .SW (SW[7:0]),
                    .CLOCK_50 (CLOCK_50),
                    .audio_data (audio_data),
                    .Sample_Clk_Signal (Sample_Clk_Signal),
                    .scope_infoASig (scope_infoASig),
                    .line2 (line2),
                    .Do_clock (Do_clock),
                    .Re_clock (Re_clock),
                    .Mi_clock (Mi_clock),
                    .Fa_clock (Fa_clock),
                    .So_clock (So_clock),
                    .La_clock (La_clock),
                    .Si_clock (Si_clock),
                    .Do2_clock (Do2_clock));

    initial begin
        CLOCK_50 = 1'b1;
        forever begin
            CLOCK_50 = 1'b0;
            #1;
            CLOCK_50 = 1'b1;
            #1;
        end
    end

    

        initial begin

            SW [7:0] = 8'b00000001;
            #200000;
            SW [7:0] = 8'b00000011;
            #200000;
            SW [7:0] = 8'b00000101;
            #200000;
            SW [7:0] = 8'b00000111;
            #200000;
            SW [7:0] = 8'b00001001;
            #200000;
            SW [7:0] = 8'b00001011;
            #200000;
            SW [7:0] = 8'b00001101;
            #200000;
            SW [7:0] = 8'b00001111;
            #200000;

            $stop;
    end   
endmodule
