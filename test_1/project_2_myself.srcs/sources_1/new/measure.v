`timescale 1ns / 1ps
`include "operate.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/06 19:42:25
// Design Name: 
// Module Name: measure
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


module measure

    #(parameter DATA_BITS = 12,
    parameter MAX_MIN_RESET_DATA_CYCLES = 2000000)
    (
    input clock,
    input dataReady,
    input signed [DATA_BITS-1:0]dataIn,
    output reg signed [DATA_BITS-1:0] signalMax = -102400, 
    output reg signed [DATA_BITS-1:0] signalMin = 102400,
    output reg signed [DATA_BITS-1:0] signalMax1 = -102400, 
    output reg signed [DATA_BITS-1:0] signalMin1 = 102400
    );
reg [25:0] timeSinceMax = 0;
 reg [25:0] timeSinceMin = 0;    
    
    
    always @(posedge clock) begin
    signalMax1<=`OPERATE(signalMax);
    signalMin1<=`OPERATE(signalMin);
        if (dataReady) begin          
            if (dataIn > signalMax) begin
                signalMax <= dataIn;
                timeSinceMax <= 0;
            end else
                timeSinceMax <= timeSinceMax + 1;
            if (dataIn < signalMin) begin
                signalMin <= dataIn;
                timeSinceMin <= 0;
            end else
                timeSinceMin <= timeSinceMin + 1;
                     
            if (timeSinceMin > MAX_MIN_RESET_DATA_CYCLES) begin
                signalMin <= dataIn;
            end            
            if (timeSinceMax > MAX_MIN_RESET_DATA_CYCLES) begin
                signalMax <= dataIn;
            end
            end
            end
endmodule
