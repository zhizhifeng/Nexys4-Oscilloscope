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
input risingEdgeReadyChannel1,
    input signed [13:0] slopeChannel1,
  input  positiveSlopeChannel1,
   input risingEdgeReadyChannel2,
   input  signed [13:0] slopeChannel2,
    input positiveSlopeChannel2,
input clock,
   input dataReady,
   input signed [DATA_BITS-1:0] dataIn,
    input signed [DATA_BITS-1:0] threshold,
    input triggerDisable,
    output isTriggered
    );
   
    EdgeTypeDetector myEdgeTypeDetectorChannel1
     (.clock(clock),
      .dataReady(adccRawReady),
      .dataIn(adccRawDataOutChannel1),
      .risingEdgeReady(risingEdgeReadyChannel1),
      .estimatedSlope(slopeChannel1),
      .estimatedSlopeIsPositive(positiveSlopeChannel1));
      
    
    
    EdgeTypeDetector myEdgeTypeDetectorChannel2
        (.clock(clock),
         .dataReady(adccRawReady),
         .dataIn(adccRawDataOutChannel2),
         .risingEdgeReady(risingEdgeReadyChannel2),
         .estimatedSlope(slopeChannel2),
         .estimatedSlopeIsPositive(positiveSlopeChannel2));
         TriggerRisingEdgeSteady Trigger
            (.clock(CLK108MHZ),
            .threshold(triggerThreshold),
            .dataReady(adccRawReady),
            .dataIn(channelSelectedData),
            .triggerDisable(~positiveSlopeChannelSelected),
            .isTriggered(isTriggered)
            );
endmodule
