module led_control (clk, audio_data, led_out);

    input logic clk;
    input logic [7:0] audio_data;
    output logic [7:0] led_out;

    parameter [7:0] num  = 8'b1111_1111; // 'd 255
    parameter [2:0] init        = 3'b000,
                    find_mbs    = 3'b001,
                    sum_up      = 3'b010,
                    display_led = 3'b011;

    logic [7:0] abs_data;
    logic [7:0] counter;
    logic [15:0] sum;
    logic [7:0] result;
    logic [2:0] state;

  
    always_ff @(posedge clk) begin
        case(state) 
            init: begin
                counter <= 0;
                sum <= 0;
                result <= 0;
                state <= find_mbs;
            end

            find_mbs: begin
                if(audio_data[7]==1'b1) begin
                    abs_data <= -audio_data;
                end 
                else begin abs_data <= audio_data; end
                state <= sum_up;
            end

            sum_up: begin
                if(counter == num) begin
                    result <= sum >> 8;
                    state <= display_led;
                end
                else begin
                    counter = counter + 1;
                    sum <= sum+abs_data;
                    state <= find_mbs;
                end
            end

            display_led: begin
                if (result >= 8'b1000_0000) begin
                    led_out <= 8'b1111_1111;
                end
                else if (result >= 8'b0100_0000) begin
                    led_out <= 8'b1111_1110;
                end
                else if (result >= 8'b0010_0000) begin
                    led_out <= 8'b1111_1100;
                end
                else if (result >= 8'b0001_0000) begin
                    led_out <= 8'b1111_1000;
                end
                else if (result >= 8'b0000_1000) begin
                    led_out <= 8'b1111_0000;
                end
                else if (result >= 8'b0000_0100) begin
                    led_out <= 8'b1110_0000;
                end
                else if (result >= 8'b0000_0010) begin
                    led_out <= 8'b1100_0000;
                end
                else if (result >= 8'b0000_0001) begin
                    led_out <= 8'b1000_0000;
                end
                else begin
                    led_out <= 8'b0000_0000;
                end
                state <= init;
            end
            default:  begin counter <= 0;
                            abs_data <= audio_data;
                            result <= 0;
                            sum <= 0;
                            led_out <= 0;
                            state <= init;
            end
        endcase
            
           
    end

endmodule