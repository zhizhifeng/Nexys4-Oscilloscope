`timescale 1ns / 1ps
`include "display.vh"

module verticaltoDecimal(
    input [`V_SCALE_BITS - 1:0] v_scale,
    output reg [`CHAR_BITS - 1:0] v_char_1,
    output reg [`CHAR_BITS - 1:0] v_char_2,
    output reg [`CHAR_BITS - 1:0] v_char_3,
    output reg [`CHAR_BITS - 1:0] v_char_4,
    output reg [`CHAR_BITS - 1:0] v_char_5
    );

    always @(*) begin
        case (v_scale)
            3'b000: begin
                v_char_1 = `CHAR_1;
                v_char_2 = `CHAR_0;
                v_char_3 = `CHAR_0;
                v_char_4 = `CHAR_PERIOD;
                v_char_5 = `CHAR_0;
            end
            3'b001: begin
                v_char_1 = `CHAR_5;
                v_char_2 = `CHAR_0;
                v_char_3 = `CHAR_PERIOD;
                v_char_4 = `CHAR_0;
                v_char_5 = `CHAR_0;
            end
            3'b010: begin
                v_char_1 = `CHAR_2;
                v_char_2 = `CHAR_5;
                v_char_3 = `CHAR_PERIOD;
                v_char_4 = `CHAR_0;
                v_char_5 = `CHAR_0;
            end
            3'b011: begin
                v_char_1 = `CHAR_1;
                v_char_2 = `CHAR_2;
                v_char_3 = `CHAR_PERIOD;
                v_char_4 = `CHAR_5;
                v_char_5 = `CHAR_0;
            end
            3'b100: begin
                v_char_1 = `CHAR_6;
                v_char_2 = `CHAR_PERIOD;
                v_char_3 = `CHAR_2;
                v_char_4 = `CHAR_5;
                v_char_5 = `CHAR_0;
            end
            3'b101: begin
                v_char_1 = `CHAR_3;
                v_char_2 = `CHAR_PERIOD;
                v_char_3 = `CHAR_1;
                v_char_4 = `CHAR_2;
                v_char_5 = `CHAR_5;
            end
            default: begin
                v_char_1 = `CHAR_SP;
                v_char_2 = `CHAR_N;
                v_char_3 = `CHAR_a;
                v_char_4 = `CHAR_N;
                v_char_5 = `CHAR_SP;
            end
        endcase
    end
endmodule
