`timescale 1ns / 1ps
module BufferSelector(
    input clock,
    input refresh,
    output reg activeBramSelect=0
    );
    
    always @(posedge clock) begin
        if (refresh)
            activeBramSelect <= ~activeBramSelect;
    end
endmodule
