`timescale 1ns / 1ps
`include "display.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/04/18 20:38:46
// Design Name:
// Module Name: infoDisplay
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


module infoDisplay (
    input clk,
    input [`DISPLAY_X_BITS - 1:0] x_cnt,
    input [`DISPLAY_Y_BITS - 1:0] y_cnt,
    output dout,
    output [`RGB_BITS - 1:0] rgb,
    output char_valid
    );

    wire [`CHAR_X_BITS - 1:0] row_addr;
    wire [`CHAR_Y_BITS - 1:0] col_addr;
    wire [`CHAR_BITS-1:0] char_data;
    charSlelect u_charSlelect(
    	.x_cnt      (x_cnt      ),
        .y_cnt      (y_cnt      ),
        .char_valid (char_valid ),
        .row_addr   (row_addr   ),
        .col_addr   (col_addr   ),
        .char_data  (char_data  ),
        .rgb        (rgb        )
    );
    charRead u_charRead(
    	.clka       (clk        ),
        .x_cnt      (x_cnt      ),
        .y_cnt      (y_cnt      ),
        .char_valid (char_valid ),
        .char_data  (char_data  ),
        .row_addr   (row_addr   ),
        .col_addr   (col_addr   ),
        .douta      (dout       )
    );

endmodule
