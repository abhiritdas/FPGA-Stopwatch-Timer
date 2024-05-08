module mode1(
    input clk,
    input reset,
    input startstop,
    output reg [15:0] value
    );
    
    reg [2:0] state;
    reg [2:0] next_state;
    reg [7:0] count; 
   
    
    always @(posedge clk) begin 
       value <= count;
       // state defintions: 000 = init, 001 = count++, 010 = keep mid count, 011 = keep 9999
        case(state) // state transitions for what to display 
            3'b000: count = 16'b0000000000000001;
            3'b001: count = count + 1;
            3'b010: count = count;    
            3'b011: count = count; 
            default: count =0;                               
        endcase
       if(reset) begin // reset no matter what
            state <= 3'b000;
            count = 16'b0000000000000001;
            end
       else if(count == 16'b1001100110011001) begin // keep 99.99 if reset not hit 
            state <= 3'b011;
            end
       else if(startstop) begin // start counting or pause counting 
            case(state)
                3'b000: state <= 3'b001; // go from count = 0 to counting up
                3'b001: state <= 3'b011; // pause counting up
            endcase
            end
       else begin
            case(state)
                3'b000: state <= 3'b000; 
                3'b001: state <= 3'b001; 
                3'b011: state <= 3'b011; 
                3'b100: state <= 3'b100; 
            endcase
            end
    end             
endmodule
