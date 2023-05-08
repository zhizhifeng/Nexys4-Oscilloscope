`timescale 1ns / 1ps
`include "display.vh"

module curveDisplay#(
    parameter RGB  = `YELLOW
    )(
    input clk,
    input [`DISPLAY_X_BITS - 1:0] x_cnt,
    input [`DISPLAY_Y_BITS - 1:0] y_cnt,
    input signed [`DATA_IN_BITS - 1:0] data_in,
    input [`RGB_BITS - 1:0] pre_rgb,
    input pre_valid,
    output reg valid,
    output [`RGB_BITS - 1:0] rgb_out,
    output [`DATA_ADDRESS_BITS - 1:0] data_address
    );
    wire [`DISPLAY_Y_BITS - 1:0] display_position;
    reg [`RGB_BITS - 1:0] rgb;

    assign display_position = `VERTICAL_ZERO + data_in;
    assign data_address = {1'b0, x_cnt};
    assign rgb_out = valid ? rgb : pre_rgb;

    always @(posedge clk) begin
        if (((display_position - 1) <= y_cnt) && (y_cnt <= (display_position + 1))) begin
            rgb <= RGB; 
            valid <= 1'b1;
        end
        else begin
            rgb <= `BLACK;
            valid <= 1'b0;
        end
    end
endmodule
