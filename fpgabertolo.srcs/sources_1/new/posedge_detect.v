
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2022 03:22:29 PM
// Design Name: 
// Module Name: posedge_detect
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps
module posedge_detect(
 input clk, pulse,
 output det
 );

 reg pulse_delay;

 always @ (posedge clk)
 begin
pulse_delay <= pulse;
end
assign det = pulse & ~pulse_delay;

endmodule

