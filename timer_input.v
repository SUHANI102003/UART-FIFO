`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2025 18:51:01
// Design Name: 
// Module Name: timer_input
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

// Cmax = [Fclk/(16*b)]-1 // Fclk = clock freq of fpga board
// here, Fclk = 100MHz
// therefore, Cmax = 650.04 or 650 == final_value
// counter countes from 0 to 650 and should generate high pulse(done) as it reaches 650
 
module timer_input
# (parameter BITS = 4)
(
input clk,
input reset_n,
input enable,
input [BITS-1:0] FINAL_VALUE, // or called divisor or Cmax (max value of counter)
output done
    );
 reg [BITS-1:0] Q_reg, Q_next;
 
 always @(posedge clk, negedge reset_n)
 begin
    if(~reset_n)
        Q_reg <=0;
    else if (enable)
        Q_reg <= Q_next;
    else
        Q_reg <= Q_reg;
 end  

// next state logic
// Combinational next-state logic
  always @(*) begin
    if (Q_reg == FINAL_VALUE)
      Q_next = 0;
    else
      Q_next = Q_reg + 1;
  end

  // Output
  assign done = (Q_reg == FINAL_VALUE);
  
  endmodule
