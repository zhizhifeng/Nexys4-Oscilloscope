`timescale 1ns / 1ps
`include "display.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/04/24 12:29:56
// Design Name:
// Module Name: display_with_clk
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


module display_with_clk(input clk,
                        input reset,
                        input [15:0] data_in,
                        output hsync,
                        output vsync,
                        output [`RGB_BITS - 1:0] rgb,
                        output [`DATA_ADDRESS_BITS - 1:0] data_address);
    
    display u_display(
    .clk          (clk_108),
    .reset        (~reset),
    .data_in_1    ({data_in[7:0],4'b0000}),
    .data_in_2    ({data_in[15:8], 4'b0000}),
    .scale_exp_1  (8),
    .scale_exp_2  (8),
    .hsync        (hsync),
    .vsync        (vsync),
    .rgb          (rgb),
    .data_address (data_address)
    );
    
    clk_wiz_0 u_clk_wiz_0
    (
    // Clock out ports
    .clk_out1(clk_108),     // output clk_out1
    // Status and control signals
    .reset(reset),          // input reset
    .locked(locked),        // output locked
    // Clock in ports
    .clk_in1(clk)           // input clk_in1
    );
endmodule
