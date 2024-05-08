`timescale 1ns / 1ps

module clkdiv2(
    input clk,
    input reset,
    output clk_out
    );
    reg[12:0] COUNT;
        
        assign clk_out=COUNT[12];
        
        always @(posedge clk)
            COUNT = COUNT + 1;
endmodule
