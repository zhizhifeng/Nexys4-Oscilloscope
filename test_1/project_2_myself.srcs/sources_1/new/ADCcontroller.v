`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/18 09:59:48
// Design Name: 
// Module Name: ADCcontroller
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


module ADCcontroller
   #(parameter IO_BITS = 12,
                NUMERATOR_SCALE_FACTOR = 11'sd1000,
                DENOMINATOR_RIGHT_SHIFT = 12,
               NUMERATOR_SCALED_DATA_BITS = 22)
   (
    input clock,
    input reset,
    input sampleEnabled,
    input inputReady,
    input [5:0]samplePeriod,
    output reg ready,
    output reg rawReady, 
    input signed [IO_BITS-1:0] dataInChannel1,
    output reg signed[IO_BITS-1:0] dataOutChannel1,
    output reg signed[IO_BITS-1:0] rawDataOutChannel1,
    input signed [IO_BITS-1:0] dataInChannel2,
    output reg signed[IO_BITS-1:0] dataOutChannel2,
    output reg signed[IO_BITS-1:0] rawDataOutChannel2
    );
    
    reg [15:0]sampleClock = 0;
    
    wire [NUMERATOR_SCALED_DATA_BITS-1:0] dataInChannel1NumeratorScaled;
    assign dataInChannel1NumeratorScaled = dataInChannel1 * NUMERATOR_SCALE_FACTOR;
    wire [NUMERATOR_SCALED_DATA_BITS-1:0] dataInChannel2NumeratorScaled;
    assign dataInChannel2NumeratorScaled = dataInChannel2 * NUMERATOR_SCALE_FACTOR;
     always @(posedge clock) begin
       
        if (!reset && sampleEnabled && inputReady) begin
            if (sampleClock >= samplePeriod) begin
                ready <= 1;
                dataOutChannel1 <= dataInChannel1NumeratorScaled >>> DENOMINATOR_RIGHT_SHIFT; 
                dataOutChannel2 <= dataInChannel2NumeratorScaled >>> DENOMINATOR_RIGHT_SHIFT; 
                sampleClock <= 0;
            end 
            else
                sampleClock <= sampleClock + 1;
            rawReady <= 1;
            rawDataOutChannel1 <= dataInChannel1;
            rawDataOutChannel2 <= dataInChannel2;
        end
         if (ready)
            ready <= 0;
        
        if (rawReady)
            rawReady <= 0;
        
        if (reset) begin
            ready <= 0;
            rawReady <= 0;
            dataOutChannel1 <= 0;
            dataOutChannel2 <= 0;
        end
    end
endmodule
