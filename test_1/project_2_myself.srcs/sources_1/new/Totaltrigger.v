`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/25 22:19:29
// Design Name: 
// Module Name: Totaltrigger
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


module Totaltrigger
#(parameter DATA_BITS = 12
     )
(
output risingEdgeReadyChannel1,
    output signed [13:0] slopeChannel1,
  output  positiveSlopeChannel1,
   output risingEdgeReadyChannel2,
   output  signed [13:0] slopeChannel2,
    output positiveSlopeChannel2,
input clock,
   input dataReady,
   input signed [DATA_BITS-1:0] dataIn1,
    input signed [DATA_BITS-1:0] dataIn2,
    input signed [DATA_BITS-1:0] dataIn3,
    input signed [DATA_BITS-1:0] threshold,
    input triggerDisable,
    output isTriggered
    );
   

    EdgeTypeDetector myEdgeTypeDetectorChannel1
     (.clock(clock),
      .dataReady(dataReady),
      .dataIn(dataIn1),
      .risingEdgeReady(risingEdgeReadyChannel1),
      .estimatedSlope(slopeChannel1),
      .estimatedSlopeIsPositive(positiveSlopeChannel1));
      
   
    
    EdgeTypeDetector myEdgeTypeDetectorChannel2
        (.clock(clock),
         .dataReady(dataReady),
         .dataIn(dataIn2),
         .risingEdgeReady(risingEdgeReadyChannel2),
         .estimatedSlope(slopeChannel2),
         .estimatedSlopeIsPositive(positiveSlopeChannel2));
         
         TriggerRisingEdgeSteady Trigger
            (.clock(clock),
            .threshold(threshold),
            .dataReady(dataReady),
            .dataIn(dataIn3),
            .triggerDisable(~triggerDisable),
            .isTriggered(isTriggered)
            );
endmodule
