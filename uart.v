`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2025 22:31:21
// Design Name: 
// Module Name: uart
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


module uart
#(
        parameter DBIT = 8,     // # data bits
                  SB_TICK = 16  // # stop bit ticks                  
     )     
    (
        input clk, reset_n,
        
        // receiver port
        output [DBIT - 1: 0] r_data,   // 2 sseg digits
        input rd_uart,                // push putton
        output rx_empty,     // led
        input rx,          // to uart
        
        // transmitter port
        input [DBIT - 1: 0] w_data,  // switches & 2 SSEG digits
        input wr_uart,   // push button
        output tx_full,  // led
        output tx,         // to uart
        
        // baud rate generator
        input [10: 0] TIMER_FINAL_VALUE   // 650 , 9600=baud
    );
    
    // Timer as baud rate generator
    wire tick;
    timer_input #(.BITS(11))baud_rate_generator (
        .clk(clk),
        .reset_n(reset_n),
        .enable(1'b1),
        .FINAL_VALUE(TIMER_FINAL_VALUE),
        .done(tick)
    );
    
    // Receiver
    wire rx_done_tick;
    wire [DBIT - 1: 0] rx_dout;
    uart_rx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) receiver(
        .clk(clk),
        .reset_n(reset_n),
        .rx(rx),
        .s_tick(tick),
        .rx_done_tick(rx_done_tick),
        .rx_dout(rx_dout)
    );
    
    fifo_generator_0 rx_FIFO (
        .clk(clk),          // input wire clk
        .srst(~reset_n),    // input wire srst
        .din(rx_dout),      // input wire [7 : 0] din
        .wr_en(rx_done_tick),  // input wire wr_en
        .rd_en(rd_uart),    // input wire rd_en
        .dout(r_data),      // output wire [7 : 0] dout
        .full(),            // output wire full
        .empty(rx_empty)    // output wire empty
    );

    // Transmitter
    wire tx_fifo_empty, tx_done_tick;
    wire [DBIT - 1: 0] tx_din;
    uart_tx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) transmitter(
        .clk(clk),
        .reset_n(reset_n),
        .tx_start(~tx_fifo_empty),
        .s_tick(tick),
        .tx_din(tx_din),
        .tx_done_tick(tx_done_tick),
        .tx(tx)
    );
    
    fifo_generator_0 tx_FIFO (
        .clk(clk),          // input wire clk
        .srst(~reset_n),    // input wire srst
        .din(w_data),      // input wire [7 : 0] din
        .wr_en(wr_uart),  // input wire wr_en
        .rd_en(tx_done_tick),    // input wire rd_en
        .dout(tx_din),      // output wire [7 : 0] dout
        .full(tx_full),            // output wire full
        .empty(tx_fifo_empty)    // output wire empty
    );    
endmodule
