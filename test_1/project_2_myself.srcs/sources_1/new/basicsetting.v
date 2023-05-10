`timescale 1ns / 1ps
`include "operate.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/06 19:23:14
// Design Name: 
// Module Name: basicsetting
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


module basicsetting
#(parameter DATA_BITS = 12, SAMPLE_PERIOD_BITS = 6, SCALE_FACTOR_SIZE = 10,
      parameter TRIGGER_THRESHOLD_ADJUST = 3 << (DATA_BITS - 7),
                SCALE_EXPONENT_BITS = 4,
                DISPLAY_Y_BITS = 12,
                INCREASE_PIXEL_COUNT = 1000000, //1,000,000
                COUNT_BITS = 20)
    (input clock,
     input [15:0] sw,
     input btnu, input btnd, input btnc, input btnl,
      output reg signed [DATA_BITS-1:0]triggerThreshold = 0,
      output reg signed [DATA_BITS-1:0]triggerThreshold1 = 0,
      output reg [SAMPLE_PERIOD_BITS-1:0]samplePeriod = 0,
     output reg channelSelected,
     output reg [2:0]scale_exp1=0,
     output reg [2:0]scale_exp2=0,
     output reg xyenable
     );
     always @(posedge clock) begin
                 triggerThreshold1 <=(triggerThreshold*1000)>>12;
        case (sw[3:0])
          4'b0000: 
             if (btnu) triggerThreshold <= triggerThreshold + TRIGGER_THRESHOLD_ADJUST;
             else if (btnd) triggerThreshold <= triggerThreshold - TRIGGER_THRESHOLD_ADJUST;

             4'b0001:          
            if (btnu) samplePeriod <= samplePeriod + 1;
            else if (btnd) samplePeriod <= samplePeriod - 1;
         4'b0010:            
            if (btnu) channelSelected = ~channelSelected;   
            4'b0100:
            if(btnu)begin scale_exp1=scale_exp1+1;
            if(scale_exp1==4'b101)scale_exp1=0;end
            else if(btnd)begin scale_exp1=scale_exp1-1;
            if(scale_exp1==4'b0)scale_exp1=4'b101;
            end          
            4'b1000:
            if(btnu)begin scale_exp2=scale_exp2+1;
            if(scale_exp2==4'b101)scale_exp2=0;end
            else if(btnd)begin scale_exp2=scale_exp2-1;
            if(scale_exp2==4'b0)scale_exp2=4'b101;
            end       
            4'b0011:
            xyenable=1;
            default:
           xyenable=0 ;
            endcase  
            end   
endmodule
