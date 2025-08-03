`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.08.2025 13:38:02
// Design Name: 
// Module Name: uart_tx_tb_simple
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

`timescale 1ns / 1ps

module uart_tx_tb_simple;

  // Parameters
  localparam DBIT = 8;
  localparam SB_TICK = 16;
  localparam BITS = 4;
  localparam FINAL_VALUE = 4'd15; // Generates s_tick every 16 clock cycles

  // Signals
  reg clk = 0;
  reg reset_n = 0;
  reg tx_start = 0;
  reg [DBIT-1:0] tx_din;
  wire tx_done_tick;
  wire tx;
  wire s_tick;

  // Clock generation (10ns clock period)
  always #5 clk = ~clk;

  // Instantiate DUT
  uart_tx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) uut (
    .clk(clk),
    .reset_n(reset_n),
    .tx_start(tx_start),
    .s_tick(s_tick),
    .tx_din(tx_din),
    .tx_done_tick(tx_done_tick),
    .tx(tx)
  );

  // Instantiate timer to generate s_tick
  timer_input #(.BITS(BITS)) timer_inst (
    .clk(clk),
    .reset_n(reset_n),
    .enable(1'b1),
    .FINAL_VALUE(FINAL_VALUE),
    .done(s_tick)
  );

  // Stimulus
  initial begin
    // Apply reset
    reset_n = 0;
    #20;
    reset_n = 1;

    // Load data and trigger transmission
    tx_din = 8'b10101011;
    #20;
    tx_start = 1;
    #10;
    tx_start = 0;

    // Let the transmission run
    #100000;

    $finish;
  end

  // Monitor the tx line
  initial begin
  $display("Time\tTX");
  $monitor("%0t\t%b", $time, tx);
end

endmodule


