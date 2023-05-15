`timescale 1ns / 1ps
module EdgeTypeDetector #(parameter DATA_BITS = 12)
                         (input clock,
                          input dataReady,
                          input signed [DATA_BITS-1:0] dataIn,
                          output wire risingEdgeReady,
                          output reg signed [DATA_BITS-1:0] estimatedSlope,
                          output wire estimatedSlopeIsPositive);
    
    reg signed [DATA_BITS-1:0] previousSamples[5:0];
    reg signed[DATA_BITS+1:0] intermediates[5:1];
    
    reg signed [DATA_BITS+1:0] previousSmoothedSamples[4:0];
    reg signed [DATA_BITS+1:0] smoothedSample;
    
    assign risingEdgeReady = dataReady;
    
    assign estimatedSlopeIsPositive = estimatedSlope > 0;
    
    reg [4:0] state;
    
    always @(posedge clock) begin
        if (dataReady) begin
            state          <= 0;
            estimatedSlope <= (smoothedSample - previousSmoothedSamples[4]) << 5;
            
            previousSmoothedSamples[0] <= smoothedSample;
            previousSmoothedSamples[1] <= previousSmoothedSamples[0];
            previousSmoothedSamples[2] <= previousSmoothedSamples[1];
            previousSmoothedSamples[3] <= previousSmoothedSamples[2];
            previousSmoothedSamples[4] <= previousSmoothedSamples[3];
            
            
            previousSamples[0] <= dataIn;
            previousSamples[1] <= previousSamples[0];
            previousSamples[2] <= previousSamples[1];
            previousSamples[3] <= previousSamples[2];
            previousSamples[4] <= previousSamples[3];
            previousSamples[5] <= previousSamples[4];
        end else begin
            if (state < 7) begin
                state <= state + 1;

                intermediates[5] <= previousSamples[1];
                intermediates[4] <= 2 * previousSamples[2];
                intermediates[3] <= 3 * previousSamples[3];
                intermediates[2] <= 2 * previousSamples[4];
                intermediates[1] <= previousSamples[5];
                
                smoothedSample <= (intermediates[5] + intermediates[4] + intermediates[3] + intermediates[2] + intermediates[1]) >> 3;
            end
        end
    end
endmodule
            
            
            
