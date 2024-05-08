`timescale 1ns / 1ps

module timeMultiplexingMain(
    input clk,
    input reset,
    input [1:0] mode,
    input [7:0] sw,
    input startstop,
    output [3:0] an,
    output [6:0] sseg);
    reg [15:0] value;
    wire [15:0] value1, value2, value3, value4;
    reg [3:0] in0, in1, in2, in3;
    wire [6:0] out0, out1, out2, out3;    
    wire slow_clk;
    
    mode1 c1(.clk(clk), .reset(reset), .startstop(startstop), .value(value1));
    mode2 c2(.clk(clk), .reset(reset), .startstop(startstop), .sw(sw), .value(value2));
    mode3 c3(.clk(clk), .reset(reset), .startstop(startstop), .value(value3));
    mode4 c4(.clk(clk), .reset(reset), .startstop(startstop), .sw(sw), .value(value4));
    
    always @(*) begin
        case(mode) // pick mode
            2'b00: value = value1;
            2'b01: value = value2;
            2'b10: value = value3;
            2'b11: value = value4;
        endcase 
        in0 = value[3:0]; // separate value into each digit      
        in1 = value[7:4];     
        in2 = value[11:8];     
        in3 = value[15:12];     
    end     
    
    // module instanation of hexto7segment decoder 
    hexto7segment c5(.x(in0), .r(out0));
    hexto7segment c6(.x(in1), .r(out1));
    hexto7segment c7(.x(in2), .r(out2));
    hexto7segment c8(.x(in3), .r(out3));
        
    // module instantiation of the clock divider 
    clkdiv c9(clk, reset, slow_clk);
    
    // module instantation of the mux
    display c10(
        .clk(slow_clk),
        .reset(reset),
        .in0(out0),
        .in1(out1),
        .in2(out2),
        .in3(out3),
        .an(an),
        .sseg(sseg));
endmodule
