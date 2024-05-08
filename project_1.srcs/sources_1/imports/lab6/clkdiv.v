`timescale 1ns / 1ps

module clkdiv(
    input clk,
    input reset,
    output clk_out
    );
    reg[19:0] COUNT;
        
        assign clk_out=COUNT[19];
        
    always @(posedge clk)
        COUNT = COUNT+1;

endmodule
