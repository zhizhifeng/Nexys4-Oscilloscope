`timescale 1ns / 1ps

module Trigger #(parameter DATA_BITS = 12)
                (input clock,
                 input dataReady,
                 input signed [DATA_BITS-1:0] dataIn1,
                 input signed [DATA_BITS-1:0] dataIn2,
                 input signed [DATA_BITS-1:0] threshold,
                 output isTriggered,
                 input channelSelected);
    
    wire [DATA_BITS-1:0] channelSelectedData;
    wire positiveSlopeChannel1;
    wire positiveSlopeChannel2;
    wire positiveSlopeChannelSelected;
    
    EdgeTypeDetector myEdgeTypeDetectorChannel1
    (.clock(clock),
    .dataReady(dataReady),
    .dataIn(dataIn1),
    .risingEdgeReady(risingEdgeReadyChannel1),
    .estimatedSlope(),
    .estimatedSlopeIsPositive(positiveSlopeChannel1));
    
    EdgeTypeDetector myEdgeTypeDetectorChannel2
    (.clock(clock),
    .dataReady(dataReady),
    .dataIn(dataIn2),
    .risingEdgeReady(risingEdgeReadyChannel2),
    .estimatedSlope(),
    .estimatedSlopeIsPositive(positiveSlopeChannel2));
    
    TriggerRisingEdgeSteady TriggerRisingEdge
    (.clock(clock),
    .threshold(threshold),
    .dataReady(dataReady),
    .dataIn(channelSelectedData),
    .triggerDisable(~positiveSlopeChannelSelected),
    .isTriggered(isTriggered)
    );
    
    SelectChannelData mySelectChannelData
    (.channel1(dataIn1),
    .channel2(dataIn2),
    .positiveSlopeChannel1(positiveSlopeChannel1),
    .positiveSlopeChannel2(positiveSlopeChannel2),
    .channelSelected(channelSelected),
    .channelSelectedData(channelSelectedData),
    .positiveSlopeChannelSelected(positiveSlopeChannelSelected)
    );
    
endmodule
