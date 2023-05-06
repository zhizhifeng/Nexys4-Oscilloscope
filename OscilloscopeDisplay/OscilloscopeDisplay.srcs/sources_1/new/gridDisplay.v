`timescale 1ns / 1ps
`include "display.vh"

module gridDisplay(
    input clk,
    input [`DISPLAY_X_BITS - 1:0] x_cnt,
    input [`DISPLAY_Y_BITS - 1:0] y_cnt,
    output reg [`RGB_BITS - 1:0] rgb
    );

    always @(*) begin
        if (((99 - `EX_CONST) <= y_cnt) && (y_cnt <= (99 + `EX_CONST))) begin
            rgb <= `GRAY; 
        end else if (((199 - `EX_CONST) <= y_cnt) && (y_cnt <= (199 + `EX_CONST))) begin
            rgb <= `GRAY; 
        end else if (((299 - `EX_CONST) <= y_cnt) && (y_cnt <= (299 + `EX_CONST))) begin
            rgb <= `GRAY; 
        end else if (((399 - `EX_CONST) <= y_cnt) && (y_cnt <= (399 + `EX_CONST))) begin
            rgb <= `GRAY; 
        end else if (((499 - `EX_CONST) <= y_cnt) && (y_cnt <= (499 + `EX_CONST))) begin
            rgb <= `GRAY; 
        end else if (((599 - `EX_CONST) <= y_cnt) && (y_cnt <= (599 + `EX_CONST))) begin
            rgb <= `GRAY; 
        end else if (((699 - `EX_CONST) <= y_cnt) && (y_cnt <= (699 + `EX_CONST))) begin
            rgb <= `GRAY; 
        end else if (((799 - `EX_CONST) <= y_cnt) && (y_cnt <= (799 + `EX_CONST))) begin
            rgb <= `GRAY; 
        end else if (((899 - `EX_CONST) <= y_cnt) && (y_cnt <= (899 + `EX_CONST))) begin
            rgb <= `GRAY; 
        end else if (((999 - `EX_CONST) <= y_cnt) && (y_cnt <= (999 + `EX_CONST))) begin
            rgb <= `WHITE;
        end else if (((39 - `EX_CONST) <= x_cnt) && (x_cnt <= (39 + `EX_CONST)) && y_cnt <999) begin
            rgb <= `GRAY;
        end else if (((139 - `EX_CONST) <= x_cnt) && (x_cnt <= (139 + `EX_CONST)) && y_cnt <999) begin
            rgb <= `GRAY;
        end else if (((239 - `EX_CONST) <= x_cnt) && (x_cnt <= (239 + `EX_CONST)) && y_cnt <999) begin
            rgb <= `GRAY;
        end else if (((339 - `EX_CONST) <= x_cnt) && (x_cnt <= (339 + `EX_CONST)) && y_cnt <999) begin
            rgb <= `GRAY;
        end else if (((439 - `EX_CONST) <= x_cnt) && (x_cnt <= (439 + `EX_CONST)) && y_cnt <999) begin
            rgb <= `GRAY;
        end else if (((539 - `EX_CONST) <= x_cnt) && (x_cnt <= (539 + `EX_CONST)) && y_cnt <999) begin
            rgb <= `GRAY;
        end else if (((639 - `EX_CONST) <= x_cnt) && (x_cnt <= (639 + `EX_CONST)) && y_cnt <999) begin
            rgb <= `GRAY;
        end else if (((739 - `EX_CONST) <= x_cnt) && (x_cnt <= (739 + `EX_CONST)) && y_cnt <999) begin
            rgb <= `GRAY;
        end else if (((839 - `EX_CONST) <= x_cnt) && (x_cnt <= (839 + `EX_CONST)) && y_cnt <999) begin
            rgb <= `GRAY;
        end else if (((939 - `EX_CONST) <= x_cnt) && (x_cnt <= (939 + `EX_CONST)) && y_cnt <999) begin
            rgb <= `GRAY;
        end else if (((1039 - `EX_CONST) <= x_cnt) && (x_cnt <= (1039 + `EX_CONST)) && y_cnt <999) begin
            rgb <= `GRAY;
        end else if (((1139 - `EX_CONST) <= x_cnt) && (x_cnt <= (1139 + `EX_CONST)) && y_cnt <999) begin
            rgb <= `GRAY;
        end else if (((1239 - `EX_CONST) <= x_cnt) && (x_cnt <= (1239 + `EX_CONST)) && y_cnt <999) begin
            rgb <= `GRAY;
        end else begin
            rgb <= `BLACK;
        end
    end
endmodule
