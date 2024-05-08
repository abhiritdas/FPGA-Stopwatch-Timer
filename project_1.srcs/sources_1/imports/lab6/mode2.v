module mode2(
    input clk,
    input reset,
    input startstop,
    input [7:0] sw,
    output reg [15:0] value
    );
    
    reg [2:0] state;
    reg [2:0] next_state;
    reg [15:0] count; 
   
    
    always @(posedge clk) begin 
    
       // state defintions: 000 = init, 001 = count++, 010 = keep mid count, 011 = keep 9999
        case(state) // setting count based on state 
            3'b000: count <= sw * 100;
            3'b001: count <= count + 1;
            3'b010: count <= count;    
            3'b011: count <= 16'b0010011100001111; 
            default: count <= sw * 100;                               
        endcase
        
        if(count == 16'b0010011100001111) // set to state 3 to keep 9999
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
            value = sw * 100;
            end
       else 
            state <= next_state;
            value <= count;
    end             
endmodule
