`timescale 1ns / 1ps
`include "display.vh"

//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/04/18 19:28:01
// Design Name:
// Module Name: oscilloscope
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


module oscilloscope#(parameter                                       
                     DRP_ADDRESS_BITS = 7,
                     DRP_SAMPLE_BITS = 16,
                     SAMPLE_BITS = 12,
                     TOGGLE_CHANNELS_STATE_BITS = 2                                       
                     )
                    (input CLK100MHZ,
                     input vauxp11,
                     input vauxn11,
                     input vauxp3,
                     input vauxn3,
                     input [15:0] SW,
                     input BTNU,
                     input BTND,
                     input BTNC,
                     input BTNL,
                     output hsync,
                     output vsync,
                     output [`RGB_BITS - 1:0] rgb);
    
    wire reset;
    assign reset = 0;
    
    
    wire CLK108MHZ;
    clk_wiz_0 ClockDivider
    (
    
    .clk_in1(CLK100MHZ),
    
    .clk_out1(CLK108MHZ),
    
    .reset(reset), // input reset
    .locked(locked));
    
    wire signed [11:0] triggerThreshold;
    wire signed [11:0] triggerThreshold1;
    wire [5:0] samplePeriod;
    wire channelSelected;
    wire [3:0] scale_exp1;
     wire [3:0] scale_exp2;
     wire xyenable;
   basicsetting basicsetting (.clock(CLK108MHZ), .sw(SW[15:0]),
    .btnu(BTNU), .btnd(BTND), .btnc(BTNC), .btnl(BTNL),  
    .triggerThreshold(triggerThreshold), 
    .triggerThreshold1(triggerThreshold1),
    .samplePeriod(samplePeriod), .channelSelected(channelSelected),
    .scale_exp1(scale_exp1),
    .scale_exp2(scale_exp2),
    .xyenable(xyenable)
    );

    wire [DRP_ADDRESS_BITS-1:0] DRPAddress;
    wire DRPEnable;
    wire DRPWriteEnable;
    wire DRPReady;
    wire signed [DRP_SAMPLE_BITS-1:0] DRPDataOut;
    wire endOfConversion;
    
    wire channelDataReady;
    wire [TOGGLE_CHANNELS_STATE_BITS-1:0] state;
    wire [TOGGLE_CHANNELS_STATE_BITS-1:0] previousState;
    wire adcc_ready;
    wire adccRawReady;
    wire signed [11:0] ADCCdataOutChannel1;
    wire signed [11:0] adccRawDataOutChannel1;
    wire signed [11:0] ADCCdataOutChannel2;
    wire signed [11:0] adccRawDataOutChannel2;
    ADC adc(
    .channelDataReady(channelDataReady),
    .state(state),
    .previousState(previousState),
    .adcc_ready(adcc_ready),
    .adccRawReady(adccRawReady),
    .ADCCdataOutChannel1(ADCCdataOutChannel1),
    .adccRawDataOutChannel1(adccRawDataOutChannel1),
    .ADCCdataOutChannel2(ADCCdataOutChannel2),
    .adccRawDataOutChannel2(adccRawDataOutChannel2),
    .di_in(),
    .daddr_in(DRPAddress),
    .den_in(DRPEnable),
    .dwe_in(DRPWriteEnable),
    .clk(CLK108MHZ),
    .reset(reset),
    .vp_in(),
    .vn_in(),
    .vauxp3(vauxp3),
    .vauxn3(vauxn3),
    .vauxp11(vauxp11),
    .vauxn11(vauxn11),
    .samplePeriod(samplePeriod),
    .dataOutChannel1(ADCCdataOutChannel1),
    .rawDataOutChannel1(adccRawDataOutChannel1),
    .dataOutChannel2(ADCCdataOutChannel2),
    .rawDataOutChannel2(adccRawDataOutChannel2),
    .ready(adcc_ready),
    .rawReady(adccRawReady)
    );
    
    wire risingEdgeReadyChannel1;
    wire signed [13:0] slopeChannel1;
    wire positiveSlopeChannel1;
    wire risingEdgeReadyChannel2;
    wire signed [13:0] slopeChannel2;
    wire positiveSlopeChannel2;
    wire isTriggered;
    
    wire [SAMPLE_BITS-1:0] channelSelectedData;
    wire positiveSlopeChannelSelected;
 
    Totaltrigger totaltrigger(
    .risingEdgeReadyChannel1(risingEdgeReadyChannel1),
    .slopeChannel1(slopeChannel1),
    .positiveSlopeChannel1(positiveSlopeChannel1),
    .risingEdgeReadyChannel2(risingEdgeReadyChannel2),
    .slopeChannel2(slopeChannel2),
    .positiveSlopeChannel2(positiveSlopeChannel2),
    .clock(CLK108MHZ),
    .dataReady(adccRawReady),
    .dataIn1(adccRawDataOutChannel1),
    .dataIn2(adccRawDataOutChannel2),
    .dataIn3(channelSelectedData),
    .threshold(triggerThreshold1),
    .triggerDisable(~positiveSlopeChannelSelected),
    .isTriggered(isTriggered)
    );
    wire activeBramSelect;
    wire refresh;
    BufferSelector mybs(
    .clock(CLK108MHZ),
   .refresh(refresh),
    .activeBramSelect(activeBramSelect)
    );
    
    wire [11:0] bufferDataOutChannel1;
    wire[11:0]data_address;
    buffer BufferChannel1 (.clock(CLK108MHZ), .ready(adcc_ready), .dataIn(ADCCdataOutChannel1),
    .isTrigger(isTriggered), .disableCollection(0), .activeBramSelect(activeBramSelect),
    .reset(reset),
    .readTriggerRelative(1),
    .readAddress(data_address),
    .dataOut(bufferDataOutChannel1));
    
    wire [11:0] bufferDataOutChannel2;
    buffer BufferChannel2 (.clock(CLK108MHZ), .ready(adcc_ready), .dataIn(ADCCdataOutChannel2),
    .isTrigger(isTriggered), .disableCollection(0), .activeBramSelect(activeBramSelect),
    .reset(reset),
    .readTriggerRelative(1),
    .readAddress(data_address),
    .dataOut(bufferDataOutChannel2));
    
    
    SelectChannelData mySelectChannelData
    (.clock(CLK108MHZ),
    .channel1(adccRawDataOutChannel1),
    .channel2(adccRawDataOutChannel2),
    .positiveSlopeChannel1(positiveSlopeChannel1),
    .positiveSlopeChannel2(positiveSlopeChannel2),    
    .channelSelected(channelSelected),
    .channelSelectedData(channelSelectedData),
    .positiveSlopeChannelSelected(positiveSlopeChannelSelected)
    );
    wire signed[11:0]Maxchannel1;
    wire signed[11:0]Maxchannel2;
    wire signed[11:0]Minchannel1;
    wire signed[11:0]Minchannel2;
    wire signed[11:0]max1;
    wire signed[11:0]max2;
    wire signed[11:0]min1;
    wire signed[11:0]min2;
    display u_display(
    .clk             (CLK108MHZ),
    .reset           (~reset),
    .trigger_channel (channelSelected),
    .data_in_1       (bufferDataOutChannel1),
    .data_in_2       (bufferDataOutChannel2),
    .h_scale         (samplePeriod),
    .v_scale_1       (scale_exp1),
    .v_scale_2       (scale_exp2),
    .data_in_1_max   (max1),
    .data_in_2_max   (max2),
    .data_in_1_min   (min1),
    .data_in_2_min   (min2),
    .tri_threshold(triggerThreshold1),
    .refresh(refresh),
    .hsync_out       (hsync),
    .vsync_out       (vsync),
    .rgb             (rgb),
    .data_address    (data_address)
    );
    
    
measure signal1(
                .clock(CLK108MHZ),
                .dataReady(adccRawReady),
                .dataIn(ADCCdataOutChannel1),              
                .signalMax(MaxChannel1),
                .signalMin(MinChannel1),
                .signalMax1(max1),
                .signalMin1(min1)
                );
measure signal2(
                .clock(CLK108MHZ),
                .dataReady(adccRawReady),
                .dataIn(ADCCdataOutChannel2),              
                .signalMax(MaxChannel2),
                .signalMin(MinChannel2),
                .signalMax1(max2),
                .signalMin1(min2)
                );
              
                ila_0 your_instance_name (
	.clk(CLK108MHZ), // input wire clk


	.probe0(min2), // input wire [11:0]  probe0  
	.probe1(min1), // input wire [11:0]  probe1 
	.probe2(bufferDataOutChannel1), // input wire [11:0]  probe2 
	.probe3(bufferDataOutChannel2), // input wire [11:0]  probe3 
	.probe4(isTriggered), // input wire [0:0]  probe4 
	.probe5(activeBramSelect) // input wire [0:0]  probe5
);

                
endmodule