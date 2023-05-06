`timescale 1ns / 1ps
`include "display.vh"

module display(input clk,
               input reset,
               input [`DATA_IN_BITS - 1:0] data_in_1,
               input [`DATA_IN_BITS - 1:0] data_in_2,
               input [`SCALE_BITS - 1:0] scale_exp_1,
               input [`SCALE_BITS - 1:0] scale_exp_2,
               output hsync,
               output vsync,
               output [`RGB_BITS - 1:0] rgb,
               output [`DATA_ADDRESS_BITS - 1:0] data_address
               );

    wire [`DATA_IN_BITS - 1:0] data_in_scaled_1;
    wire [`DATA_IN_BITS - 1:0] data_in_scaled_2;
    wire [`DISPLAY_X_BITS - 1:0] h_cnt;
    wire [`DISPLAY_Y_BITS - 1:0] v_cnt;
    wire valid;
    wire valid_1;
    wire valid_2;
    wire char_valid;

    VGA #(
    .TYPE (0)
    )
    u_VGA(
    .pclk  (clk),
    .reset (reset),
    .hsync (hsync),
    .vsync (vsync),
    .valid (valid),
    .h_cnt (h_cnt),
    .v_cnt (v_cnt)
    );
    yScale u_yScale_1(
    .data_in        (data_in_1),
    .scale_exp      (scale_exp_1),
    .data_in_scaled (data_in_scaled_1)
    );

    yScale u_yScale_2(
    .data_in        (data_in_2),
    .scale_exp      (scale_exp_2),
    .data_in_scaled (data_in_scaled_2)
    );
    
    wire [`RGB_BITS - 1:0] rgb_info;
    wire [`RGB_BITS - 1:0] rgb_curve_1;
    wire [`RGB_BITS - 1:0] rgb_curve_2;
    
    infoDisplay u_infoDisplay(
    .clk        (clk),
    .x_cnt      (h_cnt),
    .y_cnt      (v_cnt),
    .rgb        (rgb_info),
    .char_valid (char_valid)
    );
    
    curveDisplay#(
    .RGB (`YELLOW)
    )
    u_curveDisplay_1(
    .clk          (clk),
    .x_cnt        (h_cnt),
    .y_cnt        (v_cnt),
    .data_in      (data_in_scaled_1),
    .rgb          (rgb_curve_1),
    .data_address (data_address),
    .valid        (valid_1)
    );

    curveDisplay#(
    .RGB (`BLUE)
    )
    u_curveDisplay_2(
    .clk          (clk),
    .x_cnt        (h_cnt),
    .y_cnt        (v_cnt),
    .data_in      (data_in_scaled_2),
    .rgb          (rgb_curve_2),
    .data_address (data_address),
    .valid        (valid_2)
    );
    
    assign rgb = (valid) ? (char_valid ? rgb_info : (valid_1 ? rgb_curve_1 : rgb_curve_2)) : `BLACK;
    
    
endmodule
