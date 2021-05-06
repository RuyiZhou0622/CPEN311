module Flash_handle (syncclk22K, clk50M, direction, done_signal, kbd_start, address, flash_mem_read, flash_mem_readdata, audio_out, interrupt);

    input logic syncclk22K, clk50M, direction, done_signal, kbd_start;
    input logic [31:0] flash_mem_readdata;

    output logic flash_mem_read;
    output logic [22:0] address;
    output logic [7:0] audio_out;
    ////lab3
    output logic interrupt;

    parameter [5:0] idle       = 6'b0_00_000,
                    rdflash    = 6'b0_01_001,
                    gtdata     = 6'b0_00_010,
                    rddata     = 6'b1_00_011,
                    checkorder = 6'b0_00_100,
                    finish     = 6'b0_10_101;
                   
    //set the initial address and the final address
    parameter [22:0] initial_addr = 23'h0,
                     final_addr   = 23'h7FFFF;

    logic [5:0] state;

    always_ff @(posedge clk50M) begin
        case (state)
            idle: 
                // if the keyboard outputs the start signal, go to read the flash
                if(kbd_start) state <= rdflash;
                else state <= idle;

            rdflash:
                // communicate with the Read_data fsm. If the read process is finished, go next state
                if(done_signal) state <= gtdata;
                else state <= rdflash;

            gtdata: 
                // after got the data, send the data at rate of 22 kHz
                if(syncclk22K) state <= rddata;
                else state <= gtdata;
         
            rddata: begin
                // play the music according to the direction signal from the keyboard
                // There are 2 samples in each read, only the first byte is useful
                if (direction) audio_out <= flash_mem_readdata [31:24];
                else audio_out <= flash_mem_readdata [15:8];

                state <= checkorder;
            end

            checkorder: begin
                // if the direction is forward, read the address from the initial address
                if(!direction) begin
                    if (address == final_addr) address <= initial_addr;
                    //address moves forward
                    else address <= address + 23'b1;
                end
                //if the direction is backword, read the address from the final address
                else begin 
                    if (address == initial_addr) address <= final_addr;
                    // address moves backward
                    else address <= address - 23'b1;
                end
          
                state <= finish;
            end

            finish:
                state <= idle;
            
        default: begin
                        audio_out <= 0;
                        address <= initial_addr;
                        state <= idle;
                end
        endcase

    end
//Set the output
    always_ff @(posedge clk50M) begin

        flash_mem_read <= state [3];
        audio_out <= audio_out;
        address <= address;
        interrupt <= state [5];

    end
  
endmodule