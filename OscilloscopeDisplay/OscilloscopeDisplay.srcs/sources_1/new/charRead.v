`timescale 1ns / 1ps
`include "display.vh"

module charRead(
    input clka,
    input [`DISPLAY_X_BITS - 1:0] x_cnt,
    input [`DISPLAY_Y_BITS - 1:0] y_cnt,
    input [`CHAR_BITS-1:0] char_data,
    input [`CHAR_X_BITS-1:0] row_addr,
    input [`CHAR_Y_BITS-1:0] col_addr,
    output douta
    );

    wire [`CHAR_BITS + `CHAR_X_BITS + `CHAR_Y_BITS -1 : 0] addra;
    assign addra = {char_data, row_addr, col_addr};

    CharROM CharROM_0 (
    .clka(clka),    // input wire clka
    .addra(addra),  // input wire [15 : 0] addra
    .douta(douta)   // output wire [0 : 0] douta
    );

endmodule
