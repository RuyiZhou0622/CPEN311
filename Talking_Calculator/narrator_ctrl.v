// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator timestep should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module narrator_ctrl
  (
  input  clk,
  input [7:0] phoneme_sel,
  output [23:0] start_address,
  output [23:0] end_address,
  output reg silent
  );


  reg    [23:0] pointer;
  reg    [23:0] end_val;
  
  assign start_address = pointer;
  assign end_address = end_val;
 
 
  always @(posedge clk)
  begin
       case (phoneme_sel)
          8'h00:   {silent,pointer,end_val} <= {1'b1, 24'd0    , 24'd72   }; // PA1
          8'h01:   {silent,pointer,end_val} <= {1'b1, 24'd0    , 24'd216  }; // PA2
          8'h02:   {silent,pointer,end_val} <= {1'b1, 24'd0    , 24'd360  }; // PA3
          8'h03:   {silent,pointer,end_val} <= {1'b1, 24'd0    , 24'd720  }; // PA4
          8'h04:   {silent,pointer,end_val} <= {1'b1, 24'd0    , 24'd1440 }; // PA5
          8'h05:   {silent,pointer,end_val} <= {1'b0, 24'd0    , 24'd2303 }; // OY
          8'h06:   {silent,pointer,end_val} <= {1'b0, 24'd2304 , 24'd3711 }; // AY
          8'h07:   {silent,pointer,end_val} <= {1'b0, 24'd3712 , 24'd4287 }; // EH
          8'h08:   {silent,pointer,end_val} <= {1'b0, 24'd4288 , 24'd4991 }; // KK3
          8'h09:   {silent,pointer,end_val} <= {1'b0, 24'd4992 , 24'd6207 }; // PP
          8'h0a:   {silent,pointer,end_val} <= {1'b0, 24'd6208 , 24'd7103 }; // JH
          8'h0b:   {silent,pointer,end_val} <= {1'b0, 24'd7104 , 24'd8511 }; // NN1
          8'h0c:   {silent,pointer,end_val} <= {1'b0, 24'd8512 , 24'd8959 }; // IH
          8'h0d:   {silent,pointer,end_val} <= {1'b0, 24'd8960 , 24'd9791 }; // TT2
          8'h0e:   {silent,pointer,end_val} <= {1'b0, 24'd9792 , 24'd11071}; // RR1
          8'h0f:   {silent,pointer,end_val} <= {1'b0, 24'd11072, 24'd11711}; // AX
          8'h10:   {silent,pointer,end_val} <= {1'b0, 24'd11712, 24'd13183}; // MM
          8'h11:   {silent,pointer,end_val} <= {1'b0, 24'd13184, 24'd13887}; // TT1
          8'h12:   {silent,pointer,end_val} <= {1'b0, 24'd13888, 24'd15039}; // DH1
          8'h13:   {silent,pointer,end_val} <= {1'b0, 24'd15040, 24'd16447}; // IY
          8'h14:   {silent,pointer,end_val} <= {1'b0, 24'd16448, 24'd18047}; // EY
          8'h15:   {silent,pointer,end_val} <= {1'b0, 24'd18048, 24'd18495}; // DD1
          8'h16:   {silent,pointer,end_val} <= {1'b0, 24'd18496, 24'd19199}; // UW1
          8'h17:   {silent,pointer,end_val} <= {1'b0, 24'd19200, 24'd20095}; // AO
          8'h18:   {silent,pointer,end_val} <= {1'b0, 24'd20096, 24'd20927}; // AA
          8'h19:   {silent,pointer,end_val} <= {1'b0, 24'd20928, 24'd22079}; // YY2
          8'h1a:   {silent,pointer,end_val} <= {1'b0, 24'd22080, 24'd22911}; // AE
          8'h1b:   {silent,pointer,end_val} <= {1'b0, 24'd22912, 24'd23679}; // HH1
          8'h1c:   {silent,pointer,end_val} <= {1'b0, 24'd23680, 24'd24063}; // BB1
          8'h1d:   {silent,pointer,end_val} <= {1'b0, 24'd24064, 24'd25151}; // TH
          8'h1e:   {silent,pointer,end_val} <= {1'b0, 24'd25152, 24'd25855}; // UH
          8'h1f:   {silent,pointer,end_val} <= {1'b0, 24'd25856, 24'd27263}; // UW2
          8'h20:   {silent,pointer,end_val} <= {1'b0, 24'd27264, 24'd29247}; // AW
          8'h21:   {silent,pointer,end_val} <= {1'b0, 24'd29248, 24'd29887}; // DD2
          8'h22:   {silent,pointer,end_val} <= {1'b0, 24'd29888, 24'd30783}; // GG3
          8'h23:   {silent,pointer,end_val} <= {1'b0, 24'd30784, 24'd31807}; // VV
          8'h24:   {silent,pointer,end_val} <= {1'b0, 24'd31808, 24'd32447}; // GG1
          8'h25:   {silent,pointer,end_val} <= {1'b0, 24'd32448, 24'd34047}; // SH
          8'h26:   {silent,pointer,end_val} <= {1'b0, 24'd34048, 24'd35199}; // ZH
          8'h27:   {silent,pointer,end_val} <= {1'b0, 24'd35200, 24'd36159}; // RR2
          8'h28:   {silent,pointer,end_val} <= {1'b0, 24'd36160, 24'd37055}; // FF
          8'h29:   {silent,pointer,end_val} <= {1'b0, 24'd37056, 24'd38207}; // KK2
          8'h2a:   {silent,pointer,end_val} <= {1'b0, 24'd38208, 24'd39167}; // KK1
          8'h2b:   {silent,pointer,end_val} <= {1'b0, 24'd39168, 24'd40383}; // ZZ
          8'h2c:   {silent,pointer,end_val} <= {1'b0, 24'd40384, 24'd41983}; // NG
          8'h2d:   {silent,pointer,end_val} <= {1'b0, 24'd41984, 24'd42687}; // LL
          8'h2e:   {silent,pointer,end_val} <= {1'b0, 24'd42688, 24'd43839}; // WW
          8'h2f:   {silent,pointer,end_val} <= {1'b0, 24'd43840, 24'd45759}; // XR
          8'h30:   {silent,pointer,end_val} <= {1'b0, 24'd45760, 24'd47103}; // WH
          8'h31:   {silent,pointer,end_val} <= {1'b0, 24'd47104, 24'd47871}; // YY1
          8'h32:   {silent,pointer,end_val} <= {1'b0, 24'd47872, 24'd49087}; // CH
          8'h33:   {silent,pointer,end_val} <= {1'b0, 24'd49088, 24'd50047}; // ER1
          8'h34:   {silent,pointer,end_val} <= {1'b0, 24'd50048, 24'd51711}; // ER2
          8'h35:   {silent,pointer,end_val} <= {1'b0, 24'd51712, 24'd53055}; // OW
          8'h36:   {silent,pointer,end_val} <= {1'b0, 24'd53056, 24'd54463}; // DH2
          8'h37:   {silent,pointer,end_val} <= {1'b0, 24'd54464, 24'd55039}; // SS
          8'h38:   {silent,pointer,end_val} <= {1'b0, 24'd55040, 24'd56191}; // NN2
          8'h39:   {silent,pointer,end_val} <= {1'b0, 24'd56192, 24'd57215}; // HH2
          8'h3a:   {silent,pointer,end_val} <= {1'b0, 24'd57216, 24'd59071}; // OR
          8'h3b:   {silent,pointer,end_val} <= {1'b0, 24'd59072, 24'd60671}; // AR
          8'h3c:   {silent,pointer,end_val} <= {1'b0, 24'd60672, 24'd62591}; // YR
          8'h3d:   {silent,pointer,end_val} <= {1'b0, 24'd62592, 24'd63167}; // GG2
          8'h3e:   {silent,pointer,end_val} <= {1'b0, 24'd63168, 24'd64255}; // EL
          8'h3f:   {silent,pointer,end_val} <= {1'b0, 24'd64256, 24'd65535}; // BB2
          default: {silent,pointer,end_val} <= {1'b1, 24'd0    , 24'd0    }; // PA0
        endcase
  end
 
endmodule