`timescale 1ns / 1ps
`include "display.vh"

module xyDisplay#(parameter RGB = `GREEN)
                 (input clk,
                  input [`DISPLAY_X_BITS - 1:0] x_cnt,
                  input [`DISPLAY_Y_BITS - 1:0] y_cnt,
                  input signed [`DATA_IN_BITS - 1:0] data_in_1,
                  input signed [`DATA_IN_BITS - 1:0] data_in_2,
                  input [`RGB_BITS - 1:0] pre_rgb,
                  input pre_valid,
                  output reg valid,
                  output [`RGB_BITS - 1:0] rgb_out,
                  output [`DATA_ADDRESS_BITS - 1:0] data_address);

    wire [`DATA_IN_BITS - 1:0] x_position;
    wire [`DATA_IN_BITS - 1:0] y_position;
    wire x_cnt_delay;
    reg [`DISPLAY_X_LEN - 1:0] row_buffer [0:1];
    reg buffer_switch = 0;

    assign x_position = `HORIZONTAL_ZERO + data_in_1;
    assign y_position = `VERTICAL_ZERO - data_in_2;
    assign x_cnt_delay = (x_cnt == 0) ? `DISPLAY_X_LEN - 1 : (x_cnt == 1 ? `DISPLAY_X_LEN - 1 : x_cnt - 2);

    always @(posedge clk) begin
        if (y_position == (y_cnt + 1)) begin
            row_buffer[~buffer_switch][x_cnt_delay] <= 1;
        end else begin
            row_buffer[~buffer_switch][x_cnt_delay] <= 0;
        end

        if(x_cnt == `DISPLAY_X_LEN - 1) begin
            buffer_switch <= ~buffer_switch;
        end
        valid <= row_buffer[buffer_switch][x_cnt];
        row_buffer[buffer_switch][x_cnt_delay] <= 0;
    end

    assign data_address = {1'b0, x_cnt};
    assign rgb_out = valid ? RGB : pre_rgb;

endmodule