
module clockdivider (clkin,
                     Do,
                     Re,
                     Mi,
                     Fa,
                     So,
                     La,
                     Si,
                     Do2,
                     oneHz);

    input logic clkin;
    output logic Do;
    output logic Re;
    output logic Mi;
    output logic Fa;
    output logic So;
    output logic La;
    output logic Si;
    output logic Do2;
    output logic oneHz;
  

    parameter divider_Do = 32'd95602;
    parameter divider_Re = 32'd85179;
    parameter divider_Mi = 32'd75873;
    parameter divider_Fa = 32'd71633;
    parameter divider_So = 32'd63857;
    parameter divider_La = 32'd56818;
    parameter divider_Si = 32'd50659;
    parameter divider_Do2 = 32'd47801;
    parameter divider_oneHz = 32'd50000000;


    logic [31:0] count_Do = 32'b0;
    logic [31:0] count_Re = 32'b0;
    logic [31:0] count_Mi = 32'b0;
    logic [31:0] count_Fa = 32'b0;
    logic [31:0] count_So = 32'b0;
    logic [31:0] count_La = 32'b0;
    logic [31:0] count_Si = 32'b0;
    logic [31:0] count_Do2 = 32'b0;
    logic [31:0] count_oneHz = 32'b0;
    logic compare_Do;
    logic compare_Re;
    logic compare_Mi;
    logic compare_Fa;
    logic compare_So;
    logic compare_La;
    logic compare_Si;
    logic compare_Do2;
    logic compare_oneHz;
    
    //Generate the frequency of Do
    always @ (posedge clkin) begin

        //Check if the counter is greater than the HALF of the divbisor
        //The divisor is halfed because the clcok has 2 output values: 1 and 0.

        compare_Do = (count_Do < (divider_Do/2));
        
        count_Do <= count_Do + 1; //start to count the number

        //If the count is added to equal the divisor. Start to re_count from 0.
        if(count_Do==(divider_Do -1))begin
            count_Do <= 0;
        end

        // Seperate the time to 2 equal amount. 
        // One of them outputs the value 1.
        // The other one outputs the value 0.
         case (compare_Do) 
            1'b1: begin
                Do <=1'b1;
            end
            1'b0: begin
                Do <=1'b0;
            end
            default: compare_Do <= 1'b0;
        endcase
        
    //Generate the frequency of Re
        compare_Re = (count_Re < (divider_Re/2));
        count_Re <= count_Re + 1; 

        if(count_Re==(divider_Re -1))begin
            count_Re <= 0;
        end

         case (compare_Re) 
            1'b1: begin
                Re <=1'b1;
            end
            1'b0: begin
                Re <=1'b0;
            end
            default: compare_Re <= 1'b0;
        endcase
        
    //Generate the frequency of Mi
        compare_Mi = (count_Mi < (divider_Mi/2));
        count_Mi <= count_Mi + 1; 

        if(count_Mi==(divider_Mi -1))begin
            count_Mi <= 0;
        end

         case (compare_Mi) 
            1'b1: begin
                Mi <=1'b1;
            end
            1'b0: begin
                Mi <=1'b0;
            end
            default: compare_Mi <= 1'b0;
        endcase
        
    //Generate the frequency of Fa
        compare_Fa = (count_Fa < (divider_Fa/2));
        count_Fa <= count_Fa + 1; 

        if(count_Fa==(divider_Fa -1))begin
            count_Fa <= 0;
        end

         case (compare_Fa) 
            1'b1: begin
                Fa <=1'b1;
            end
            1'b0: begin
                Fa <=1'b0;
            end
            default: compare_Fa <= 1'b0;
        endcase
        
    //Generate the frequency of So
        compare_So = (count_So < (divider_So/2));
        count_So <= count_So + 1; 

        if(count_So==(divider_So -1))begin
            count_So <= 0;
        end

         case (compare_So) 
            1'b1: begin
                So <=1'b1;
            end
            1'b0: begin
                So <=1'b0;
            end
            default: compare_So <= 1'b0;
        endcase
        
    //Generate the frequency of La
        compare_La = (count_La < (divider_La/2));
        count_La <= count_La + 1; 

        if(count_La==(divider_La -1))begin
            count_La <= 0;
        end

         case (compare_La) 
            1'b1: begin
                La <=1'b1;
            end
            1'b0: begin
                La <=1'b0;
            end
            default: compare_La <= 1'b0;
        endcase
        
    //Generate the frequency of Si
        compare_Si = (count_Si < (divider_Si/2));
        count_Si <= count_Si + 1; 

        if(count_Si==(divider_Si -1))begin
            count_Si <= 0;
        end

         case (compare_Si) 
            1'b1: begin
                Si <=1'b1;
            end
            1'b0: begin
                Si <=1'b0;
            end
            default: compare_Si <= 1'b0;
        endcase
        
     //Generate the frequency of Do2
        compare_Do2 = (count_Do2 < (divider_Do2/2));
        count_Do2 <= count_Do2 + 1;

        if(count_Do2==(divider_Do2 -1))begin
            count_Do2 <= 0;
        end

         case (compare_Do2) 
            1'b1: begin
                Do2 <=1'b1;
            end
            1'b0: begin
                Do2 <=1'b0;
            end
            default: compare_Do2 <= 1'b0;
        endcase

        //Generate the frequency of oneHz
        compare_oneHz = (count_oneHz < (divider_oneHz/2));
        count_oneHz <= count_oneHz + 1;

        if(count_oneHz==(divider_oneHz -1))begin
            count_oneHz <= 0;
        end

         case (compare_oneHz) 
            1'b1: begin
                oneHz <=1'b1;
            end
            1'b0: begin
                oneHz <=1'b0;
            end
            default: compare_oneHz <= 1'b0;
        endcase
        
    end

endmodule

