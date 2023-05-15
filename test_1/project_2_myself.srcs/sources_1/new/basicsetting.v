`timescale 1ns / 1ps

module basicsetting#(parameter DATA_BITS = 12,
                               SAMPLE_PERIOD_BITS = 6,
                               TRIGGER_THRESHOLD_ADJUST = 3 << (DATA_BITS - 7),
                               SCALE_EXPONENT_BITS = 4)
                    (input clock,
                     input [15:0] sw,
                     input btnu, input btnd, input btnc, input btnl,
                     output reg signed [DATA_BITS-1:0]triggerThreshold = 0,
                     output reg signed [DATA_BITS-1:0]triggerThreshold1 = 0,
                     output reg [SAMPLE_PERIOD_BITS-1:0]samplePeriod = 0,
                     output reg channelSelected = 0,
                     output reg [2:0]scale_exp1 = 0,
                     output reg [2:0]scale_exp2 = 0,
                     output reg xyenable = 0
                     );
    always @(posedge clock) begin
        triggerThreshold1 <=(triggerThreshold*1000)>>12;
        case (sw[4:0])
            5'b00000: 
                if (btnu) triggerThreshold <= triggerThreshold + TRIGGER_THRESHOLD_ADJUST;
                else if (btnd) triggerThreshold <= triggerThreshold - TRIGGER_THRESHOLD_ADJUST;
            5'b00001:          
                if (btnu) samplePeriod <= samplePeriod + 1;
                else if (btnd) samplePeriod <= samplePeriod - 1;
            5'b00010:            
                if (btnu) channelSelected = ~channelSelected;   
            5'b00100:
                if(btnu) begin 
                    scale_exp1=scale_exp1+1;
                    if(scale_exp1 == 4'b101)scale_exp1=0;
                end else if(btnd) begin
                    scale_exp1=scale_exp1-1;
                    if(scale_exp1 == 4'b0)scale_exp1=4'b101;
                end          
            5'b01000:
                if(btnu)begin
                    scale_exp2=scale_exp2+1;
                    if(scale_exp2 == 4'b101)scale_exp2=0;
                end else if(btnd)begin
                    scale_exp2=scale_exp2-1;
                    if(scale_exp2 == 4'b0)scale_exp2=4'b101;
                end       
            5'b10000:
                xyenable = 1;
            default:
                xyenable = 0;
        endcase  
    end   
endmodule
