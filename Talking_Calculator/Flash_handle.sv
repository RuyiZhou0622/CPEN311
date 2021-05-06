module Flash_handle (syncclk72, clk50M, start_address, end_address, done_signal, silent, done, address, flash_mem_read, flash_mem_readdata, audio_out, interrupt, start, reset);

    input logic syncclk72, clk50M, done_signal, silent;
    input logic [31:0] flash_mem_readdata;
    input logic [23:0] start_address, end_address;
    input logic [7:0] done;

    output logic flash_mem_read;
    output logic [23:0] address;
    output logic [7:0] audio_out;
    output logic interrupt;
    output logic [7:0] start;
    output logic [7:0] reset;

    parameter [6:0] idle                     = 7'b0_00_0000,
                    rdflash                  = 7'b0_10_0001,
                    gtdata                   = 7'b0_00_0010,
                    get_address              = 7'b0_00_0011,
                    get_start_remainder_data = 7'b0_00_0100,
                    get_end_remainder_data   = 7'b0_00_0101,
                    rddata_1                 = 7'b0_00_0110,
                    rddata_2                 = 7'b0_00_0111,
                    rddata_3                 = 7'b0_00_1000,
                    rddata_4                 = 7'b0_00_1001,
                    change_addr              = 7'b0_00_1010,
                    finish                   = 7'b0_01_1011,
                    init                     = 7'b0_00_1100,
                    wait_1                   = 7'b0_00_1101,
                    wait_2                   = 7'b0_00_1110,
                    wait_3                   = 7'b0_00_1111,
                    wait_4                   = 7'b1_00_0000,
                    wait_initial             = 7'b1_00_0001,
                    wait_finish              = 7'b1_00_0010;
   
    logic [6:0] state;
    logic [23:0] start_word_addr, end_word_addr;
    logic [31:0] temp_data;
    logic [23:0] test_address;

    logic hz_72;

    assign start_word_addr = start_address>>2;
    assign end_word_addr = end_address>>2;
    assign temp_data [31:0] = flash_mem_readdata [31:0];
   
    edge_capture capture (.clk(clk50M), .in_sig(syncclk72), .out_sig(hz_72));

    always_ff @(posedge clk50M) begin
        case (state)
            init: begin
                test_address <= start_word_addr;
                reset <= 8'b0000_0000;
                if(done[0]) state <= idle;
                else state <= init;
            end
            idle: begin
                // if the keyboard outputs the start signal, go to read the flash
                //if(done[0]) state <= rdflash; 
                reset <= 8'b0000_0001;
                 state <= rdflash;
            end
            rdflash:begin
                // communicate with the Read_data fsm. If the read process is finished, go next state
                if(done_signal) state <= gtdata;
                else state <= rdflash;
            end
            gtdata: begin
                // after got the data, send the data at rate of 22 kHz
                if(hz_72) state <= rddata_1;
               
                else state <= gtdata;
            end
            rddata_1: begin
                // play the music according to the direction signal from the keyboard
                // There are 2 samples in each read, only the first byte is useful
                audio_out <= silent ? 8'b0000_0000 : flash_mem_readdata [7:0];

                if(hz_72) state <= rddata_2;
            end

        

            rddata_2: begin
                audio_out <= silent ? 8'b0000_0000 : flash_mem_readdata [15:8];
                if(hz_72) state <= rddata_3;
            end

        

            rddata_3: begin
                audio_out <= silent ? 8'b0000_0000 : flash_mem_readdata [23:16];
                if(hz_72)  state <= rddata_4;
            end

      

            rddata_4: begin
                audio_out <= silent ? 8'b0000_0000 : flash_mem_readdata [31:24];
                if(hz_72)  state <= change_addr;
            end
        
    

            change_addr: begin

                    if (test_address == end_word_addr) 
                    begin 
                         state <= finish; 
                    
                    end
                
                    else begin
                        test_address <= test_address + 24'b00000000_00000000_00000001;
                         state <= wait_finish;
                    end     
            end
            wait_finish: begin
                 state <= idle;
            end

            finish: begin
                if(done[0]) begin 
                    state <= init;
                    reset <= 8'b0000_0000;
                end
                else   state <= finish;
            end

                default: begin
                    reset <= 8'b0;
                    audio_out <= 0;
                    test_address <= start_word_addr;
                    state <= init;
            end
    endcase

end

   assign  flash_mem_read = state [5];
   assign  interrupt = 1'b0;
   assign address = test_address;
   assign start = {7'b0000_000, state [4]};
   

  
endmodule

