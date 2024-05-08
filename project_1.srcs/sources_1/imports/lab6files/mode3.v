module mode3(
    input clk,
    input reset,
    input startstop,
    output reg [15:0] value
    );
    
    reg [2:0] state;
    reg [2:0] next_state;
    reg [7:0] count; 
    
    always @(*) begin 
    // state defintions: 000 = init, 001 = count--, 010 = keep mid count, 011 = keep 0
        case(state) // state transitions for what to display 
            3'b000: count = 9999;
            3'b001: count = count - 1;
            3'b010: count = count;    
            3'b011: count = count;                                
        endcase
    end     
    
    always @(posedge clk) begin 
       value <= count;       
       if(reset) begin // reset no matter what
            state <= 3'b000;
            end
       else if(count == 0) begin // keep 0 if reset not hit 
            state <= 3'b011;
            end
       else if(startstop) begin // start counting or pause counting 
            case(state)
                3'b000: state <= 3'b001; // go from count = 9999 to counting down
                3'b001: state <= 3'b011; // pause counting down
            endcase
            end
    end             
endmodule
