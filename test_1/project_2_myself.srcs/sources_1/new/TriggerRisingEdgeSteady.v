`timescale 1ns / 1ps

module TriggerRisingEdgeSteady #(parameter DATA_BITS = 12,
                                 parameter TRIGGER_HOLDOFF = 0)
                                (input clock,
                                 input signed [DATA_BITS-1:0] threshold,
                                 input dataReady,
                                 input signed [DATA_BITS-1:0] dataIn,
                                 input triggerDisable,
                                 output reg isTriggered);
    
    reg signed [DATA_BITS-1:0] previousData[10:0];
    
    genvar i;
    generate
    for (i = 0; i < 10 ; i = i + 1) begin
        always @(posedge clock) begin
            if (dataReady)
                previousData[i+1] <= previousData[i];
        end
    end
    endgenerate
            
    always @(posedge clock) begin
        if (dataReady) begin
            previousData[0] <= dataIn;
            if (previousData[10] < threshold && previousData[6] >= threshold && !triggerDisable)
                isTriggered <= 1;
            else
                isTriggered <= 0;
        end
    end
endmodule
