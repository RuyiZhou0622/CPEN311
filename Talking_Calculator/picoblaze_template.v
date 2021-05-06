//mount c c:\
//C:
//cd KCPSM3/Assembler
//KCPSM3 speech > compile.log
`default_nettype none
 `define USE_PACOBLAZE
module 
picoblaze_template
#(
parameter clk_freq_in_hz = 25000000
) (
				//output reg[7:0] led,
				input clk,
		//		input [7:0] input_data,
  		  output wire [23:0] sseg,
        //set the output for the heart-beat LED
        output reg led0,
        output reg [7:0] out_sel,
        input interrupt_in,
        input reg [7:0] start,
        input reg [7:0] reset_pico,
        output reg [7:0] done,
        input reg [7:0] select_key,
        input reg [7:0] check_equal,
        output reg [7:0] equal_done
      //  input reg [7:0] start_pico,
      //  output reg [7:0] pico_done
			     );


  
//--
//------------------------------------------------------------------------------------
//--
//-- Signals used to connect KCPSM3 to program ROM and I/O logic
//--

wire[9:0]  address;
wire[17:0]  instruction;
wire[7:0]  port_id;
wire[7:0]  out_port;
//reg [7:0] start;
reg[7:0]  in_port;
wire  write_strobe;
wire  read_strobe;
reg  interrupt;
//wire done;
wire  interrupt_ack;
wire  kcpsm3_reset;

//--
//-- Signals used to generate interrupt 
//--
reg[26:0] int_count;
reg event_1hz;

//-- Signals for LCD operation
//--
//--

reg        lcd_rw_control;
reg[7:0]   lcd_output_data;
pacoblaze3 led_8seg_kcpsm
(
                  .address(address),
               .instruction(instruction),
                   .port_id(port_id),
              .write_strobe(write_strobe),
                  .out_port(out_port),
               .read_strobe(read_strobe),
                   .in_port(in_port),
                 .interrupt(interrupt),
             .interrupt_ack(interrupt_ack),
                     .reset(kcpsm3_reset),
                       .clk(clk));

 wire [19:0] raw_instruction;
	
	pacoblaze_instruction_memory 
	pacoblaze_instruction_memory_inst(
     	.addr(address),
	    .outdata(raw_instruction)
	);
	
	always @ (posedge clk)
	begin
	      instruction <= raw_instruction[17:0];
	end

    assign kcpsm3_reset = 0;                       
  
//  ----------------------------------------------------------------------------------------------------------------------------------
//  -- Interrupt 
//  ----------------------------------------------------------------------------------------------------------------------------------
//  --
//  --
//  -- Interrupt is used to provide a 1 second time reference.
//  --
//  --
//  -- A simple binary counter is used to divide the 50MHz system clock and provide interrupt pulses.
//  --


// Note that because we are using clock enable we DO NOT need to synchronize with clk
//now the interrupt is triggered when the interrupt_in is 1, the event_1Hz is not useful.

 always @ (posedge clk or posedge interrupt_ack)  //FF with clock "clk" and reset "interrupt_ack"
 begin
      if (interrupt_ack) //if we get reset, reset interrupt in order to wait for next clock.
            interrupt <= 0;
      else
		begin 
		          if (interrupt_in)   //clock enable
      		      interrupt <= 1;
          		else
		            interrupt <= interrupt;
      end
 end

//  --
//  ----------------------------------------------------------------------------------------------------------------------------------
//  -- KCPSM3 input ports 
//  ----------------------------------------------------------------------------------------------------------------------------------
//  --
//  --
//  -- The inputs connect via a pipelined multiplexer
//  --

 always @ (posedge clk)
 begin
    case (port_id[7:0])
        8'h0:    in_port <= start;
        8'h1:    in_port <= reset_pico;
        8'h2:    in_port <= select_key;
        8'h3:    in_port <= check_equal;
      //  8'h4:    in_port <= start_pico;
        default: in_port <= 8'bx;
    endcase
end
   
//
//  --
//  ----------------------------------------------------------------------------------------------------------------------------------
//  -- KCPSM3 output ports 
//  ----------------------------------------------------------------------------------------------------------------------------------
//  --
//  -- adding the output registers to the processor
//  --
//   
  always @ (posedge clk)
  begin

        //port 80 hex 
      //  if (write_strobe & port_id[7])  //clock enable 
      //    led <= out_port;
 ////////Final project////
      if (write_strobe & port_id[7])
            out_sel [7:0] <= out_port;
        //port 40 hex 
        if (write_strobe & port_id[6])  //clock enable 
          done [7:0] <= out_port;
			      
		  //port 20 hex 
		  if (write_strobe & port_id[5])  //clock enable 
         equal_done [7:0] <= out_port;
			      
		  //port 10 hex 			
   //     if (write_strobe & port_id[4])  //clock enable 
      //    pico_done [7:0] <= out_port;
        
      //////////Use an empty port. Port 8 hex
       // if (write_strobe & port_id[3])
        //  led0 <= out_port [0];

     
			      
  end

endmodule
