`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/21 09:34:19
// Design Name: 
// Module Name: TriggerRisingEdgeSteady
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


module TriggerRisingEdgeSteady
    #(parameter DATA_BITS = 12,
      parameter TRIGGER_HOLDOFF = 0)
    (input clock,
    input signed [DATA_BITS-1:0] threshold,
    input dataReady,
    input signed [DATA_BITS-1:0] dataIn,
    input triggerDisable,
    output reg isTriggered
    );
    
    reg [4:0]samplesSinceTrigger = 0;
    
    reg signed [DATA_BITS-1:0] previousData[5:0];
    
    genvar i;
    generate
    for (i = 0; i < 5 ; i = i + 1) begin
        always @(posedge clock) begin
            if (dataReady)
                previousData[i+1] <= previousData[i];
        end
    end
    endgenerate

    
    always @(posedge clock) begin
        if (dataReady) begin
            previousData[0] <= dataIn;
            
            samplesSinceTrigger <= (samplesSinceTrigger < 500) ? samplesSinceTrigger + 1 : samplesSinceTrigger;
            
            if (previousData[5]<threshold && dataIn>=threshold && !triggerDisable && samplesSinceTrigger > TRIGGER_HOLDOFF) begin
                isTriggered <= 1;
                samplesSinceTrigger <= 0;
            end else
                isTriggered <= 0;
        end
    end
    
   
endmodule
