`timescale 1ns / 1ps
`include "display.vh"

module binarytoBCD(input signed [`DATA_IN_BITS - 1:0] bin_in,
                   output reg sign,
                   output reg [15:0] bcd);
    
    integer i;
    reg signed [`DATA_IN_BITS - 1:0] bin;

    always @(*) begin
        bin = bin_in;
        bcd = 0;
        // if negative, make positive and set sign bit
        if (bin < 0) begin
            bin = -bin;
            sign = 1;
        end else begin
            sign = 0;
        end
        // convert binary to BCD
        for (i = 0;i < 12;i = i+1) begin
            // add 3 to each BCD digit if it is greater than 4
            if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;
            if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;
            if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;
            if (bcd[15:12] >= 5) bcd[15:12] = bcd[15:12] + 3;
            // shift BCD left
            bcd = {bcd[14:0],bin[11-i]};
        end
    end
endmodule
