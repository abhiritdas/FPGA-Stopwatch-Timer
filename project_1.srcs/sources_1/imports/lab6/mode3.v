module mode3(
    input clk,
    input reset,
    input startstop,
    output reg [15:0] value
//    output reg [2:0] state
    );
    
    reg [2:0] state;
    reg [2:0] next_state;
    reg [15:0] count; 
   
    
    always @(posedge clk) begin 
       // state defintions: 000 = init, 001 = count++, 010 = keep mid count, 011 = keep 9999
        case(state) // setting count based on state 
            3'b000: count <= 16'b0010011100001111;
            3'b001: count <= count - 1;
            3'b010: count <= count;    
            3'b011: count <= 16'b0000000000000000; 
            default: count <= 16'b0010011100001111;                               
        endcase
        
        if(count == 16'b0000000000000000) // set to state 3 to keep 9999
            next_state <= 3'b011; 
        else if(startstop) begin // setting next_state if startstop
            case(state) 
                3'b000: next_state = 3'b001;
                3'b001: next_state = 3'b010;
                3'b010: next_state = 3'b001;
            endcase
        end    
        else // keep state 
            next_state <= state;  
               
       if(reset) begin // reset no matter what
            state <= 3'b000;
            value <= 16'b0010011100001111;  
            end
       else 
            state <= next_state;
            value <= count; 
    end             
endmodule
