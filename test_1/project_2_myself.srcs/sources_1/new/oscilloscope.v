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


module oscilloscope#(parameter DISPLAY_X_BITS = 12,
                     DISPLAY_Y_BITS = 12,
                     ADDRESS_BITS = 12,
                     RGB_BITS = 12,
                     X_MIDDLE_VOLTAGE_CHARACTER_4 = 1_100,
                     Y_MIDDLE_VOLTAGE_CHARACTER_4 = 496,
                     X_MIDDLE_VOLTAGE_CHARACTER_3 = 1_120,
                     Y_MIDDLE_VOLTAGE_CHARACTER_3 = 496,
                     X_MIDDLE_VOLTAGE_CHARACTER_2 = 1_140,
                     Y_MIDDLE_VOLTAGE_CHARACTER_2 = 496,
                     X_MIDDLE_VOLTAGE_CHARACTER_1 = 1_160,
                     Y_MIDDLE_VOLTAGE_CHARACTER_1 = 496,
                     X_MIDDLE_VOLTAGE_CHARACTER_0 = 1_180,
                     Y_MIDDLE_VOLTAGE_CHARACTER_0 = 496,
                     X_TIME_PER_DIVISION_CHARACTER_4 = 200,
                     Y_TIME_PER_DIVISION_CHARACTER_4 = 980,
                     X_TIME_PER_DIVISION_CHARACTER_3 = 220,
                     Y_TIME_PER_DIVISION_CHARACTER_3 = 980,
                     X_TIME_PER_DIVISION_CHARACTER_2 = 240,
                     Y_TIME_PER_DIVISION_CHARACTER_2 = 980,
                     X_TIME_PER_DIVISION_CHARACTER_1 = 260,
                     Y_TIME_PER_DIVISION_CHARACTER_1 = 980,
                     X_TIME_PER_DIVISION_CHARACTER_0 = 280,
                     Y_TIME_PER_DIVISION_CHARACTER_0 = 980,
                     Y_VOLTAGE_PER_DIVISION_CHARACTER = 744,
                     X_VOLTAGE_PER_DIVISION_CHARACTER_4 = 0,
                     X_VOLTAGE_PER_DIVISION_CHARACTER_3 = 20,
                     X_VOLTAGE_PER_DIVISION_CHARACTER_2 = 40,
                     X_VOLTAGE_PER_DIVISION_CHARACTER_1 = 60,
                     X_VOLTAGE_PER_DIVISION_CHARACTER_0 = 80,
                     Y_MAX = 12,
                     X_MAX_CHARACTER_9 = 200,
                     X_MAX_CHARACTER_8 = 220,
                     X_MAX_CHARACTER_7 = 240,
                     X_MAX_CHARACTER_6 = 260,
                     X_MAX_CHARACTER_5 = 280,
                     X_MAX_CHARACTER_4 = 300,
                     X_MAX_CHARACTER_3 = 320,
                     X_MAX_CHARACTER_2 = 340,
                     X_MAX_CHARACTER_1 = 360,
                     X_MAX_CHARACTER_0 = 380,
                     Y_MIN = 44,
                     X_MIN_CHARACTER_9 = 200,
                     X_MIN_CHARACTER_8 = 220,
                     X_MIN_CHARACTER_7 = 240,
                     X_MIN_CHARACTER_6 = 260,
                     X_MIN_CHARACTER_5 = 280,
                     X_MIN_CHARACTER_4 = 300,
                     X_MIN_CHARACTER_3 = 320,
                     X_MIN_CHARACTER_2 = 340,
                     X_MIN_CHARACTER_1 = 360,
                     X_MIN_CHARACTER_0 = 380,
                     Y_CURSOR_1 = 12,
                     X_CURSOR_1_CHARACTER_15 = 940,
                     X_CURSOR_1_CHARACTER_14 = 960,
                     X_CURSOR_1_CHARACTER_13 = 980,
                     X_CURSOR_1_CHARACTER_12 = 1000,
                     X_CURSOR_1_CHARACTER_11 = 1020,
                     X_CURSOR_1_CHARACTER_10 = 1040,
                     X_CURSOR_1_CHARACTER_9 = 1060,
                     X_CURSOR_1_CHARACTER_8 = 1080,
                     X_CURSOR_1_CHARACTER_7 = 1100,
                     X_CURSOR_1_CHARACTER_6 = 1120,
                     X_CURSOR_1_CHARACTER_5 = 1140,
                     X_CURSOR_1_CHARACTER_4 = 1160,
                     X_CURSOR_1_CHARACTER_3 = 1180,
                     X_CURSOR_1_CHARACTER_2 = 1200,
                     X_CURSOR_1_CHARACTER_1 = 1220,
                     X_CURSOR_1_CHARACTER_0 = 1240,
                     Y_CURSOR_2 = 44,
                     X_CURSOR_2_CHARACTER_15 = 940,
                     X_CURSOR_2_CHARACTER_14 = 960,
                     X_CURSOR_2_CHARACTER_13 = 980,
                     X_CURSOR_2_CHARACTER_12 = 1000,
                     X_CURSOR_2_CHARACTER_11 = 1020,
                     X_CURSOR_2_CHARACTER_10 = 1040,
                     X_CURSOR_2_CHARACTER_9 = 1060,
                     X_CURSOR_2_CHARACTER_8 = 1080,
                     X_CURSOR_2_CHARACTER_7 = 1100,
                     X_CURSOR_2_CHARACTER_6 = 1120,
                     X_CURSOR_2_CHARACTER_5 = 1140,
                     X_CURSOR_2_CHARACTER_4 = 1160,
                     X_CURSOR_2_CHARACTER_3 = 1180,
                     X_CURSOR_2_CHARACTER_2 = 1200,
                     X_CURSOR_2_CHARACTER_1 = 1220,
                     X_CURSOR_2_CHARACTER_0 = 1240,
                     Y_VOLTAGE_CURSOR_DIFFERENCE = 76,
                     X_VOLTAGE_CURSOR_DIFFERENCE_CHARACTER_15 = 940,
                     X_VOLTAGE_CURSOR_DIFFERENCE_CHARACTER_14 = 960,
                     X_VOLTAGE_CURSOR_DIFFERENCE_CHARACTER_13 = 980,
                     X_VOLTAGE_CURSOR_DIFFERENCE_CHARACTER_12 = 1000,
                     X_VOLTAGE_CURSOR_DIFFERENCE_CHARACTER_11 = 1020,
                     X_VOLTAGE_CURSOR_DIFFERENCE_CHARACTER_10 = 1040,
                     X_VOLTAGE_CURSOR_DIFFERENCE_CHARACTER_9 = 1060,
                     X_VOLTAGE_CURSOR_DIFFERENCE_CHARACTER_8 = 1080,
                     X_VOLTAGE_CURSOR_DIFFERENCE_CHARACTER_7 = 1100,
                     X_VOLTAGE_CURSOR_DIFFERENCE_CHARACTER_6 = 1120,
                     X_VOLTAGE_CURSOR_DIFFERENCE_CHARACTER_5 = 1140,
                     X_VOLTAGE_CURSOR_DIFFERENCE_CHARACTER_4 = 1160,
                     X_VOLTAGE_CURSOR_DIFFERENCE_CHARACTER_3 = 1180,
                     X_VOLTAGE_CURSOR_DIFFERENCE_CHARACTER_2 = 1200,
                     X_VOLTAGE_CURSOR_DIFFERENCE_CHARACTER_1 = 1220,
                     X_VOLTAGE_CURSOR_DIFFERENCE_CHARACTER_0 = 1240,
                     X_CHANNEL_SELECTED = 12,
                     Y_CHANNEL_SELECTED = 12,
                     SELECT_CHARACTER_BITS = 7,
                     DRP_ADDRESS_BITS = 7,
                     DRP_SAMPLE_BITS = 16,
                     SAMPLE_BITS = 12,
                     TOGGLE_CHANNELS_STATE_BITS = 2,
                     SCALE_FACTOR_BITS = 10,
                     DIGIT_BITS = 4,
                     CURSOR_VOLTAGE_BITS = 12,
                     SCALE_EXPONENT_BITS = 4,
                     TIME_PER_DIVISION_BITS = 10,
                     REAL_DISPLAY_WIDTH = 1688,
                     REAL_DISPLAY_HEIGHT = 1066,
                     PIXELS_PER_DIVISION = 8'sd100,
                     GREEN = 12'h0C0,
                     LIGHT_PURPLE = 12'hF6F,
                     YELLOW = 12'hFF0,
                     BLUE = 12'h0FF,
                     VERY_LIGHT_PURPLE = 12'hFCF)
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
    
    wire btnu_clean, btnd_clean, btnc_clean, btnl_clean;
    wire btnu_1pulse,btnd_1pulse,btnc_1pulse,btnl_1pulse;
    wire signed [11:0] triggerThreshold;
    wire [9:0] verticalScaleFactorTimes8Channel1;
    wire [9:0] verticalScaleFactorTimes8Channel2;
    wire [5:0] samplePeriod;
    wire channelSelected;
    
    
    wire signed [11:0] signalMinChannel1;
    wire signed [11:0] signalMaxChannel1;
    wire [11:0] signalPeriodChannel1;
    wire signed [11:0] signalAverageChannel1;
    wire signed [11:0] signalMinChannel2;
    wire signed [11:0] signalMaxChannel2;
    wire [11:0] signalPeriodChannel2;
    wire signed [11:0] signalAverageChannel2;
    
    scopesettings myss(.clock(CLK108MHZ), .sw(SW[15:0]),
    .btnu(btnu_1pulse), .btnd(btnd_1pulse), .btnc(btnc_1pulse), .btnl(btnl_1pulse),
    .signalMinChannel1(signalMinChannel1), .signalMaxChannel1(signalMaxChannel1), .signalPeriodChannel1(signalPeriodChannel1),
    .signalMinChannel2(signalMinChannel2), .signalMaxChannel2(signalMaxChannel2), .signalPeriodChannel2(signalPeriodChannel2),
    .triggerThreshold(triggerThreshold),
    .verticalScaleFactorTimes8Channel1(verticalScaleFactorTimes8Channel1),
    .verticalScaleFactorTimes8Channel2(verticalScaleFactorTimes8Channel2),
    .samplePeriod(samplePeriod), .channelSelected(channelSelected)
    );
    
    wire [3:0] verticalScaleExponentChannel1;
    wire [3:0] verticalScaleExponentChannel2;
    GetVerticalScaleExponents myGetVericalScaleExponents
    (.clock(CLK108MHZ),
    .verticalScaleFactorTimes8Channel1(verticalScaleFactorTimes8Channel1),
    .verticalScaleFactorTimes8Channel2(verticalScaleFactorTimes8Channel2),
    .verticalScaleExponentChannel1(verticalScaleExponentChannel1),
    .verticalScaleExponentChannel2(verticalScaleExponentChannel2)
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
    .sampleperiod(sampleperiod),
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
    wire [SCALE_FACTOR_BITS-1:0] verticalScaleFactorTimes8ChannelSelected;
    wire [SCALE_EXPONENT_BITS-1:0] verticalScaleExponentChannelSelected;
    
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
    .threshold(triggerThreshold),
    .triggerDisable(~positiveSlopeChannelSelected),
    .isTriggered(isTriggered)
    );
    wire drawStarting;
    wire activeBramSelect;
    BufferSelector mybs(
    .clock(CLK108MHZ),
    .drawStarting(drawStarting),
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
    .verticalScaleFactorTimes8Channel1(verticalScaleFactorTimes8Channel1),
    .verticalScaleFactorTimes8Channel2(verticalScaleFactorTimes8Channel2),
    .verticalScaleExponentChannel1(verticalScaleExponentChannel1),
    .verticalScaleExponentChannel2(verticalScaleExponentChannel2),
    .channelSelected(channelSelected),
    .channelSelectedData(channelSelectedData),
    .positiveSlopeChannelSelected(positiveSlopeChannelSelected),
    .verticalScaleFactorTimes8ChannelSelected(verticalScaleFactorTimes8ChannelSelected),
    .verticalScaleExponentChannelSelected(verticalScaleExponentChannelSelected)
    );
    display_with_clk xvga1
    (
    .clk(CLK108MHZ),
    .reset(reset),
    .data_in(bufferDataOutChannel1),
    .hsync(hsync),
    .vsync(vsync),
    .rgb(rgb),
    .data_address(data_address)
    );


endmodule
