`timescale 1ns / 1ps
`include "display.vh"

module charDisplay#(parameter RGB = `WHITE)
                   (input [`DISPLAY_X_BITS - 1:0] x_cnt,
                    input [`DISPLAY_Y_BITS - 1:0] y_cnt,
                    input [`DISPLAY_X_BITS - 1:0] x_position,
                    input [`DISPLAY_Y_BITS - 1:0] y_position,
                    input [`CHAR_BITS - 1:0] char_data,
                    input [`CHAR_BITS - 1:0] pre_char_data,
                    input [`RGB_BITS - 1:0] pre_rgb,
                    input [`CHAR_X_BITS - 1:0] pre_row_addr,
                    input [`CHAR_Y_BITS - 1:0] pre_col_addr,
                    output reg char_valid,
                    output [`CHAR_X_BITS - 1:0] row_addr_out,
                    output [`CHAR_Y_BITS - 1:0] col_addr_out,
                    output [`CHAR_BITS - 1:0] char_data_out,
                    output [`RGB_BITS - 1:0] rgb_out);
    
    reg [`CHAR_X_BITS - 1:0] row_addr;
    reg [`CHAR_Y_BITS - 1:0] col_addr;
    
    always @(*) begin
        if (x_position <= x_cnt && x_cnt < (x_position + `CHAR_X_LEN) && y_position <= y_cnt && y_cnt < (y_position + `CHAR_Y_LEN)) begin
            char_valid <= 1'b1;
            row_addr   <= x_cnt - x_position;
            col_addr   <= y_cnt - y_position;
            end else begin
            char_valid <= 1'b0;
            row_addr   <= 0;
            col_addr   <= 0;
        end
    end
    
    assign rgb_out       = char_valid ? RGB : pre_rgb;
    assign char_data_out = char_valid ? char_data : pre_char_data;
    assign row_addr_out  = char_valid ? row_addr : pre_row_addr;
    assign col_addr_out  = char_valid ? col_addr : pre_col_addr;
endmodule
