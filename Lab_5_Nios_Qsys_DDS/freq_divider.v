/* Name: Reuben Singh Joginder
   Student ID: 89291884
   E-mail: rsreuben@ubc.ca
   Course: CPEN 311
   Lab: 1
   
   Purpose: This module implements a frequency divider. The logic is to same the 50Mhz square wave in a way that the
	    output wave generated is of a desired frequency.

   Formulae: out = in/n

*/
//One bit clock signals
module freq_divider(in,n, out);
	//Definitions

	input in;
	input [25:0] n;
	output reg out;

	//Counter for a 50MHz clock. Since log(50*10^6) bits are used to represent 50Mhz
	reg [25:0] counter = 0;
	//directional flag
	reg flag = 1;
	
	//On positive edge of clock, trigger always block
	always@(posedge in)
		begin
			//if the flag is positive
			if (flag)
				begin 
					//increment counter by one
					counter = counter + 1;
					//and the output remains one 
					out = 1;
					//However on half of n, change flag to change output to 0
					if (counter == n/2) flag = 0;
				end
			else 
				begin 
					//decrement counter, results in an oscillation
					counter = counter - 1; 
					out = 0;
					//set flag to 1, when counter reaches a value of 0. So out remains 0 as long as counter is not 0.
					if (counter== 0) flag = 1;

				end
		end

endmodule
