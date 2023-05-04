`timescale 1ns / 1ps
`include "display.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 18:55:03
// Design Name: 
// Module Name: yScale
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


module yScale(
    input signed [`DATA_IN_BITS - 1:0] data_in,
    input [`SCALE_BITS - 1:0] scale_exp,
    output signed [`DATA_IN_BITS - 1:0] data_in_scaled
    );
    wire [`DATA_IN_BITS - 1:0] data_in_abs;
    wire [`DATA_IN_BITS - 1:0] data_in_abs_scaled;

    assign data_in_abs = ((data_in) > 0 ? (data_in) : (0 - data_in));
    assign data_in_abs_scaled = (scale_exp > 8) ? (data_in_abs << (scale_exp - 8)) : (data_in_abs >> (8 - scale_exp));
    assign data_in_scaled = (data_in < 0) ? (0 - data_in_abs_scaled) : data_in_abs_scaled;


endmodule

