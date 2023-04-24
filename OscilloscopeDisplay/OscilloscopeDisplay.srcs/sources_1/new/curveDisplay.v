`timescale 1ns / 1ps
`include "display.vh"

module curveDisplay#(
    parameter RGB  = `YELLOW
    )(
    input clk,
    input [`DISPLAY_X_BITS - 1:0] x_cnt,
    input [`DISPLAY_Y_BITS - 1:0] y_cnt,
    input signed [`DATA_IN_BITS - 1:0] data_in,
    output reg [`RGB_BITS - 1:0] rgb,
    output [`DATA_ADDRESS_BITS - 1:0] data_address
    );
    wire [`DISPLAY_Y_BITS - 1:0] display_position;

    assign display_position = `HORIZONTAL_ZERO - data_in;
    assign data_address = y_cnt;
    always @(posedge clk) begin
        if (((display_position - 1) <= y_cnt) && (y_cnt <= (display_position + 1))) begin
            rgb = (y_cnt == display_position) ? RGB : `BLACK; 
        end
        else begin
            rgb = `BLACK;
        end
    end
endmodule
