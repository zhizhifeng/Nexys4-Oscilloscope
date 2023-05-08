`timescale 1ns / 1ps
`include "display.vh"

module display_with_clk(input clk,
                        input reset,
                        input [15:0] data_in,
                        output hsync,
                        output vsync,
                        output [`RGB_BITS - 1:0] rgb,
                        output [`DATA_ADDRESS_BITS - 1:0] data_address);
    wire trigger_channel;
    wire [`H_SCALE_BITS - 1:0] h_scale;
    wire signed [`DATA_IN_BITS - 1:0] data_in_1_max;
    wire signed [`DATA_IN_BITS - 1:0] data_in_2_max;
    wire signed [`DATA_IN_BITS - 1:0] data_in_1_min;
    wire signed [`DATA_IN_BITS - 1:0] data_in_2_min;
    wire signed [`DATA_IN_BITS - 1:0] tri_threshold;
    
    assign trigger_channel = 1'b1;
    assign h_scale         = 6'b01010;
    assign data_in_1_max   = 12'b111100111111;
    assign data_in_2_max   = 12'b010101010101;
    assign data_in_1_min   = 12'b010101011111;
    assign data_in_2_min   = 12'b000100101010;
    assign tri_threshold   = 12'b000000111111;
    
    display u_display(
    .clk             (clk_108),
    .reset           (~reset),
    .trigger_channel (trigger_channel),
    .data_in_1       ({data_in[7:0], 4'b0000}),
    .data_in_2       ({data_in[15:8], 4'b0000}),
    .h_scale         (h_scale),
    .v_scale_1       (0),
    .v_scale_2       (0),
    .data_in_1_max   (data_in_1_max),
    .data_in_2_max   (data_in_2_max),
    .data_in_1_min   (data_in_1_min),
    .data_in_2_min   (data_in_2_min),
    .tri_threshold   (tri_threshold   ),
    .hsync_out       (hsync),
    .vsync_out       (vsync),
    .rgb             (rgb),
    .data_address    (data_address),
    .refresh ()
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
