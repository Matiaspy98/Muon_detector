
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2022 03:35:50 PM
// Design Name: 
// Module Name: freq_divider
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
module freq_divider(
 input clk, reset,
 input [31:0] div,
 output clk_out
 );
 reg[31:0] counter;
 reg sig;

 always @(posedge clk)
 begin
 if (reset)
 begin
 counter <= 0;
 sig <= 0;
 end else begin
 if(counter>div)
 begin
 counter <= 0;
 sig <= ~sig;
 end else begin
 counter <= counter + 1;
 end
 end
 end

 assign clk_out = sig;

endmodule
