`timescale 1ns / 1ps

module tb_timerStopwatch;

reg clk; 
reg reset; 
reg startstop;

wire [15:0] value;
wire [2:0] state;

mode1 u1(.clk(clk), .reset(reset), .startstop(startstop), .value(value), .state(state));

initial 
begin 
clk = 1;
reset = 1;

#50
reset = 0;
startstop = 1;

#50
reset = 0;
startstop = 0;

#50                      
reset = 1;               
startstop = 0;

#50
reset = 0;
startstop = 1;

#150
reset = 0;
startstop = 0;

#50
reset = 0;
startstop = 1;

#150
reset = 0;
startstop = 0;

end 

always
#5 clk = ~clk;

endmodule
