`timescale 1ns / 1ps
`include "display.vh"

module yScale(
    input signed [`DATA_IN_BITS - 1:0] data_in,
    input [`V_SCALE_BITS - 1:0] scale_exp,
    output signed [`DATA_IN_BITS - 1:0] data_in_scaled
    );
    wire [`DATA_IN_BITS - 1:0] data_in_abs;
    wire [`DATA_IN_BITS - 1:0] data_in_abs_scaled;

    assign data_in_abs = ((data_in) > 0 ? (data_in) : (0 - data_in));
    assign data_in_abs_scaled = data_in_abs << scale_exp;
    assign data_in_scaled = (data_in < 0) ? (0 - data_in_abs_scaled) : data_in_abs_scaled;


endmodule
