`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/20 08:57:50
// Design Name: 
// Module Name: BufferSelector
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


module BufferSelector(
    input clock,
    input drawStarting,
    output reg activeBramSelect
    );
    
    always @(posedge clock) begin
        if (drawStarting)
            activeBramSelect <= ~activeBramSelect;
    end
endmodule
