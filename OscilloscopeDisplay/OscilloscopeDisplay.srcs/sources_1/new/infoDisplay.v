`timescale 1ns / 1ps
`include "display.vh"

module infoDisplay (input clk,
                    input [`DISPLAY_X_BITS - 1:0] x_cnt,
                    input [`DISPLAY_Y_BITS - 1:0] y_cnt,
                    input [`RGB_BITS - 1:0] pre_rgb,
                    output [`RGB_BITS - 1:0] rgb,
                    output info_valid);
    
    wire [`CHAR_Y_BITS - 1:0] row_addr_1;
    wire [`CHAR_X_BITS - 1:0] col_addr_1;
    wire [`CHAR_BITS-1:0] char_data_1;
    wire [`RGB_BITS-1:0] rgb_1;
    wire char_valid_1;
    
    charDisplay
    #(
    .RGB (`WHITE)
    )
    charDisplay_CH1_C(
    .x_cnt         (x_cnt),
    .y_cnt         (y_cnt),
    .x_position    (100),
    .y_position    (1007),
    .char_data     (`CHAR_C),
    .pre_char_data (0),
    .pre_rgb       (0),
    .pre_row_addr  (0),
    .pre_col_addr  (0),
    .char_valid    (char_valid_1),
    .row_addr_out  (row_addr_1),
    .col_addr_out  (col_addr_1),
    .char_data_out (char_data_1),
    .rgb_out       (rgb_1)
    );
    
    wire [`CHAR_Y_BITS - 1:0] row_addr_2;
    wire [`CHAR_X_BITS - 1:0] col_addr_2;
    wire [`CHAR_BITS-1:0] char_data_2;
    wire [`RGB_BITS-1:0] rgb_2;
    wire char_valid_2;
    
    charDisplay
    #(
    .RGB (`WHITE)
    )
    charDisplay_CH1_H(
    .x_cnt         (x_cnt),
    .y_cnt         (y_cnt),
    .x_position    (113),
    .y_position    (1007),
    .char_data     (`CHAR_H),
    .pre_char_data (char_data_1),
    .pre_rgb       (rgb_1),
    .pre_row_addr  (row_addr_1),
    .pre_col_addr  (col_addr_1),
    .char_valid    (char_valid_2),
    .row_addr_out  (row_addr_2),
    .col_addr_out  (col_addr_2),
    .char_data_out (char_data_2),
    .rgb_out       (rgb_2)
    );

    wire [`CHAR_Y_BITS - 1:0] row_addr_3;
    wire [`CHAR_X_BITS - 1:0] col_addr_3;
    wire [`CHAR_BITS-1:0] char_data_3;
    wire [`RGB_BITS-1:0] rgb_3;
    wire char_valid_3;
    
    charDisplay
    #(
    .RGB (`WHITE)
    )
    charDisplay_CH1_1(
    .x_cnt         (x_cnt),
    .y_cnt         (y_cnt),
    .x_position    (126),
    .y_position    (1007),
    .char_data     (`CHAR_1),
    .pre_char_data (char_data_2),
    .pre_rgb       (rgb_2),
    .pre_row_addr  (row_addr_2),
    .pre_col_addr  (col_addr_2),
    .char_valid    (char_valid_3),
    .row_addr_out  (row_addr_3),
    .col_addr_out  (col_addr_3),
    .char_data_out (char_data_3),
    .rgb_out       (rgb_3)
    );

    wire dout;

    charRead u_charRead(
    .clka       (clk),
    .x_cnt      (x_cnt),
    .y_cnt      (y_cnt),
    .char_data  (char_data_3),
    .row_addr   (row_addr_3),
    .col_addr   (col_addr_3),
    .douta      (dout)
    );

    assign info_valid = rgb_3 == (12'b0) ? 1'b0 : 1'b1;
    assign rgb = (dout & info_valid) ? rgb_3 : pre_rgb;
    
endmodule
