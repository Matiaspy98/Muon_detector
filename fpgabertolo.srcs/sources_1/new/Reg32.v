
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2022 03:34:16 PM
// Design Name: 
// Module Name: Reg32
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
module reg32(
 input wire clk, reset, enable,
 input wire [31:0] D,
 output wire [31:0] Q
 );

 reg [31:0] data;

 always @(posedge clk, posedge reset)
 begin
 if (reset)
 begin
 data <= 0;
 end else begin
 if (enable)
 begin
 data <= D;
 end
 end
 end

 assign Q = data;

endmodule
