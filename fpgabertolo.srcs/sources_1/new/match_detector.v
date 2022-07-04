
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2022 03:41:53 PM
// Design Name: 
// Module Name: match_detector
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
module match_detector(
 input clk,
 input [2:0]up,
 output [4:0]matchs
 );

 reg [4:0] hits;

 always @ (posedge clk)
 begin
 hits[0] <= (up[0] & up[1]);
 hits[1] <= (up[0] & up[1]& up[2]);
 hits[2] <= (up[0]);
 hits[3] <= (up[1]);
 hits[4] <= (up[2]);
 
 end

 assign matchs = hits;

endmodule