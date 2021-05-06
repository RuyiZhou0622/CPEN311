module Read_Data (clk50M, flash_mem_waitrequest, flash_mem_readdatavalid, flash_mem_read, done_signal);
    input logic clk50M,
                flash_mem_waitrequest,
                flash_mem_readdatavalid,
                flash_mem_read;

    output logic done_signal;
                                //the first bit is used to indicate the process is finished
                                //done _ states 
    parameter [2:0] idle       = 3'b0_00,
                    reading    = 3'b0_01,
                    check_data = 3'b0_10,
                    done       = 3'b1_11;
                    
    logic [2:0] state;

    always_ff @(posedge clk50M) begin
            case(state)
                idle:  
                    //To start the process
                    if (flash_mem_read) state <= reading;
                    else state <= idle;

                reading:  
                    // To check the wait_request
                    // If the waitrequest is from 1 to 0, then check if the data is valid
                    if (flash_mem_waitrequest) state <= reading;
                    else state <= check_data;
                
                check_data: 
                    // if the read_date is valid
                    if (flash_mem_readdatavalid) state <= done;
                    else state <= check_data;
                
                done:
                    state <= idle;

                default: state <= idle;
            endcase
    end
 
    always_ff @(posedge clk50M) begin

        done_signal = state [2]; // only the DONE state will output a '1' to indicate the read_data process is finished.

    end

endmodule
    
