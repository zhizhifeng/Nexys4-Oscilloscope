`timescale 1ns / 1ps
`include "display.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 18:52:32
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
                        input [`DATA_IN_BITS - 1:0] data_in,
                        output hsync,
                        output vsync,
                        output [`RGB_BITS - 1:0] rgb,
                        output [`DATA_ADDRESS_BITS - 1:0] data_address);
    
    display u_display(
    .clk          (clk_108),
    .reset        (~reset),
    .data_in      (data_in),
    .scale_exp    (8),
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

