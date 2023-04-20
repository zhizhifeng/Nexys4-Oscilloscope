`timescale 1ns / 1ps
`include "display.vh"

module charSlelect(
    input [`DISPLAY_X_BITS - 1:0] x_cnt,
    input [`DISPLAY_Y_BITS - 1:0] y_cnt,
    output reg char_valid,
    output reg [`CHAR_X_BITS - 1:0] row_addr,
    output reg [`CHAR_Y_BITS - 1:0] col_addr,
    output reg [`CHAR_BITS - 1:0] char_data,
    output reg [`RGB_BITS - 1:0] rgb);
    always @(*) begin
        if (100 <= x_cnt && x_cnt < (100 + `CHAR_X_LEN) && 1000<= y_cnt && y_cnt < (y_cnt + `CHAR_Y_LEN)) begin
            char_valid <= 1'b1;
            row_addr <= x_cnt - 100;
            col_addr <= y_cnt - 1000;
            char_data <= `CHAR_C;
            rgb <= `RED;
        end else begin
            char_valid <= 1'b0;
            row_addr <= 0;
            col_addr <= 0;
            char_data <= 0;
            rgb <= 0;
        end
    end

endmodule
