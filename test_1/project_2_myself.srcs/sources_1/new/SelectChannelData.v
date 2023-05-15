`timescale 1ns / 1ps

module SelectChannelData #(parameter SAMPLE_BITS = 12)
                          (input [SAMPLE_BITS-1:0] channel1,
                           input [SAMPLE_BITS-1:0] channel2,
                           input positiveSlopeChannel1,
                           input positiveSlopeChannel2,
                           input channelSelected,
                           output reg [SAMPLE_BITS-1:0] channelSelectedData,
                           output reg positiveSlopeChannelSelected = 0);
    
    always @(*) begin
        if (channelSelected) begin
            channelSelectedData          <= channel2;
            positiveSlopeChannelSelected <= positiveSlopeChannel2;
        end else begin
            channelSelectedData          <= channel1;
            positiveSlopeChannelSelected <= positiveSlopeChannel1; 
        end
    end
    
endmodule
