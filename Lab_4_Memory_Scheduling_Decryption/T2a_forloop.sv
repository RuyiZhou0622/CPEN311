module T2a_forloop (clk, finish_sig, q, addr_t2, data_t2, wren_t2, addr, data_mem, wren);

    input clk,
          finish_sig, // this is 1 when Task1 in finished
          wren_t2; 
    input [7:0] q,
                addr_t2,
                data_t2;
    output [7:0] addr,
                 data_mem;
    output wren;

    logic [7:0] state,
                addr,
                data_mem,
                index_i,
                index_j,
                secret_key,
                i_data,
                j_data,
                q;
   
    logic [1:0] key;
    logic sync_fnh;

    parameter [23:0] secret_key_model  = 24'b01001001_00000010_00000000;

  
    
    ///////state [7] is wren
    parameter [7:0] l1_start         = 8'b1000_0000,
                    l1_get_addr_data = 8'b1000_0001,
                    l1_done          = 8'b0000_0010,
                    l2_start         = 8'b0000_0011,
                    l2_get_addr      = 8'b0000_0100,
                    l2_get_key       = 8'b0000_0101,
                    l2_get_j         = 8'b0000_0110,
                    l2_rd_j          = 8'b0000_0111,
                    l2_swap_j        = 8'b1000_1000,
                    l2_swap_i        = 8'b1000_1001,
                    l2_check         = 8'b0000_1010,
                    l2_idle          = 8'b0000_1011,
                    wait_1           = 8'b0000_1100,
                    wait_2           = 8'b0000_1101,
                    l1_check         = 8'b0000_1110,
                    l2_done          = 8'b0000_1111,
                    wait_3           = 8'b0001_0000,
                    wait_4           = 8'b0001_0001;
    
    //synchorizer sync (.async_sig (finish_sig), 
    //                 .outclk (clk),
    //                  .out_sync_sig (sync_fnh)
    //                 );
    
   //assign key [1:0] = index_i % 2'd3;
  //  assign key [1:0] = (index_i % 2'b11); //the length of key is 3
  
    always_ff @(posedge clk) begin
    
        if (finish_sig == 0) begin

            addr <= addr_t2;
            data_mem <= data_t2;
            wren <= wren_t2;
        end
        else begin
            wren = state [7];
            case (state) 
        /////////
            /*
           l1_start: begin
                index_i <= 8'b0000_0000;
                state <= l1_get_addr_data;
            end
           l1_get_addr_data: begin
                addr <= index_i;
               data_mem <= index_i;
               state <= l1_check;
           end
           l1_check: begin
               if (index_i == 8'b1111_1111) begin 
                   state <= l1_done; 
               end
                else begin
                   index_i <= index_i + 8'b0000_0001;
                  state <= l1_get_addr_data;
               end
            end
            l1_done: begin
              state <= l2_start;
           end
           */

///////task 2a///////////
           
            l2_start: begin //initialize the two indice
                index_i <= 8'b0;
                index_j <= 8'b0;
                state <= l2_get_addr;
            end
            l2_get_addr: begin
                addr <= index_i;
                state <= wait_3;
        
            end
            wait_3: begin
               state <= l2_get_key;
            end
            l2_get_key: begin 
                //the length of key = 3   
                if ((index_i % 2'b11) == 2'b00 ) begin 
                    secret_key <= secret_key_model [7:0];
                   
                end
                else if ((index_i % 2'b11) == 2'b01 ) begin 
                    secret_key <= secret_key_model [15:8]; 
                end
                else begin 
                   secret_key <= secret_key_model [23:16]; 
               
                end
                ///alternatively
                //case (key)
                  //  2'b00: secret_key <= 8'b0000_0000;
                 //   2'b01: secret_key <= 8'b0000_0010;
                 //   2'b10: secret_key <= 8'b0100_1001;
                //    default: secret_key <= 8'b0000_0000;
              //  endcase 
                state <= l2_get_j;
                
            end
           
            l2_get_j: begin
                addr <= index_j;
                i_data <= q;
                index_j <= index_j + q + secret_key;
                state <= wait_1;
            end

            wait_1: begin
                state <= l2_rd_j;
            end

            l2_rd_j: begin
                j_data <= q;
                state <= wait_2;
            end

            wait_2: begin
                state <= l2_swap_j;
           end

            l2_swap_j: begin
                addr <= index_i;
                data_mem <= j_data;
               
                state <= l2_swap_i;
            end
           
            l2_swap_i: begin
                addr <= index_j; 
                data_mem <= i_data;
                
                state <= l2_check;
            end
            l2_check: begin
               
                if (index_i == 8'b1111_1111) begin 
                    state <= l2_done; 
                end
                else begin
                   // index_i <= index_i + 8'b0000_0001;
                    index_i <= 0;
                    state <= l2_get_addr;
                end
            end
            
            l2_done: begin
                state <= l2_done;
            end

             //////////////////////////////////////////////////////
           

                default: state <= l2_start;
            endcase 
        end
       
    end
  
  //  s_memory T1_mem (.address(addr),
       //             .clock (clk),
        //           .data (data_mem),
        //            .wren (wren), 
        //            .q (qm)
        //             );

   

endmodule