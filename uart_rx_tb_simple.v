`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.08.2025 15:17:41
// Design Name: 
// Module Name: uart_rx_tb_simple
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

module uart_rx_tb_simple;

  // Parameters
  localparam DBIT = 8;
  localparam SB_TICK = 16;
  localparam BITS = 4;
  localparam FINAL_VALUE = 4'd15; // 16x oversampling

  // Signals
  reg clk = 0;
  reg reset_n = 0;
  reg rx = 1;  // Idle line is high
  wire rx_done_tick;
  wire [DBIT-1:0] rx_dout;
  wire s_tick;

  // Clock generation (10ns period => 100MHz)
  always #5 clk = ~clk;

  // Instantiate UART Receiver
  uart_rx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) uut (
    .clk(clk),
    .reset_n(reset_n),
    .rx(rx),
    .s_tick(s_tick),
    .rx_done_tick(rx_done_tick),
    .rx_dout(rx_dout)
  );

  // Instantiate Timer to generate s_tick every 16 clk cycles
  timer_input #(.BITS(BITS)) tick_gen (
    .clk(clk),
    .reset_n(reset_n),
    .enable(1'b1),
    .FINAL_VALUE(FINAL_VALUE),
    .done(s_tick)
  );

  // Task to send a full UART frame bit-by-bit
  reg rx_done_flag = 0;
  always @(posedge clk) begin
    if (rx_done_tick)
      rx_done_flag <= 1;
  end

  // Task to send 1 UART byte (LSB first)
  task send_uart_byte(input [7:0] data);
    integer i;
    begin
      // Send start bit
      rx = 0;
      repeat(16) @(posedge s_tick);

      // Send data bits (LSB first)
      for (i = 0; i < 8; i = i + 1) begin
        rx = data[i];
        repeat(16) @(posedge s_tick);
      end

      // Send stop bit
      rx = 1;
      repeat(16) @(posedge s_tick);
    end
  endtask

  // Test procedure
  initial begin
    $display("----- UART RX Test Start -----");

    // Reset the design
    reset_n = 0;
    #20;
    reset_n = 1;

    // Wait before sending data
    repeat(10) @(posedge clk);

    // Transmit a byte (0xAB = 10101011)
    send_uart_byte(8'b10101011);

    // Wait until rx_done_tick is registered
    wait(rx_done_flag);

    // Show result
    $display("Received Byte = %b", rx_dout);
    if (rx_dout == 8'b10101011)
      $display("Test PASSED");
    else
      $display("Test FAILED");

    $finish;
  end

  
  

endmodule