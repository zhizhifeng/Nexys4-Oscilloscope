`timescale 1ns / 1ps
`include "display.vh"

module display(input clk,
               input reset,
               input [`DATA_IN_BITS - 1:0] data_in,
               input [`SCALE_BITS - 1:0] scale_exp,
               output hsync,
               output vsync,
               output [`RGB_BITS - 1:0] rgb,
               output [`DATA_ADDRESS_BITS - 1:0] data_address
               );
    
    wire [`DATA_IN_BITS - 1:0] data_in_scaled;
    wire [`DISPLAY_X_BITS - 1:0] h_cnt;
    wire [`DISPLAY_Y_BITS - 1:0] v_cnt;
    wire valid;
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
    yScale u_yScale(
    .data_in        (data_in),
    .scale_exp      (scale_exp),
    .data_in_scaled (data_in_scaled)
    );
    
    wire [`RGB_BITS - 1:0] rgb_info;
    wire [`RGB_BITS - 1:0] rgb_curve;
    
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
    u_curveDisplay(
    .clk          (clk),
    .x_cnt        (h_cnt),
    .y_cnt        (v_cnt),
    .data_in      (data_in_scaled),
    .rgb          (rgb_curve),
    .data_address (data_address)
    );
    
    assign rgb = (valid) ? (char_valid ? rgb_info : rgb_curve) : `BLACK;
    
    
endmodule
