`timescale 1ns / 1ps
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


module oscilloscope#(parameter  DISPLAY_X_BITS = 12,
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
   input BTNU, input BTND, input BTNC, input BTNL,
   //input reset,
   output wire [15:0] LED,
   output [7:0] an,
   output dp,
   output [6:0] seg,
   output reg VGA_HS,
   output reg VGA_VS,
   output reg [3:0] VGA_R, output reg [3:0] VGA_G, output reg [3:0] VGA_B
    );
    
    wire reset;
    assign reset = 0;
    //debounce rdb(.reset(reset), .clock(CLK100MHZ), .noisy(CPU_RESETN), .clean(reset));
    
    wire CLK108MHZ;
     clk_wiz_0 ClockDivider
       (
       // Clock in ports
        .clk_in1(CLK100MHZ),      // input clk_in1
        // Clock out ports
        .clk_out1(CLK108MHZ),    // output clk_out1
        // Status and control signals
        .reset(reset), // input reset
        .locked(locked));
          // Scope settings
    wire btnu_clean, btnd_clean, btnc_clean, btnl_clean;
     wire btnu_1pulse,btnd_1pulse,btnc_1pulse,btnl_1pulse;
    wire signed [11:0] triggerThreshold;
    wire [9:0] verticalScaleFactorTimes8Channel1;
    wire [9:0] verticalScaleFactorTimes8Channel2;
    wire [5:0] samplePeriod;
    wire channelSelected;
    assign LED[15] = channelSelected;
  // these come from MeasureSignal
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
                                  wire [DRP_ADDRESS_BITS-1:0] DRPAddress;
    wire DRPEnable;
    wire DRPWriteEnable;
    wire DRPReady;
    wire signed [DRP_SAMPLE_BITS-1:0] DRPDataOut;
    wire endOfConversion;
  xadc_wiz_0 xadc (
        .di_in(),                       // input wire [15 : 0] di_in
        .daddr_in(DRPAddress),          // input wire [6 : 0] daddr_in
        .den_in(DRPEnable),             // input wire den_in
        .dwe_in(DRPWriteEnable),        // input wire dwe_in
        .drdy_out(DRPReady),            // output wire drdy_out
        .do_out(DRPDataOut),            // output wire [15 : 0] do_out
        .dclk_in(CLK108MHZ),            // input wire dclk_in
        .reset_in(reset),               // input wire reset_in
        .vp_in(),                       // input wire vp_in
        .vn_in(),                       // input wire vn_in
        .vauxp3(vauxp3),                // input wire vauxp3
        .vauxn3(vauxn3),                // input wire vauxn3
        .vauxp11(vauxp11),              // input wire vauxp11
        .vauxn11(vauxn11),              // input wire vauxn11
        .channel_out(),                 // output wire [4 : 0] channel_out
        .eoc_out(endOfConversion),      // output wire eoc_out
        .alarm_out(),                   // output wire alarm_out
        .eos_out(),                     // output wire eos_out
        .busy_out()                     // output wire busy_out
        );
        wire signed [SAMPLE_BITS-1:0] channel1;
    wire signed [SAMPLE_BITS-1:0] channel2;
    wire channelDataReady;
    wire [TOGGLE_CHANNELS_STATE_BITS-1:0] state;
    wire [TOGGLE_CHANNELS_STATE_BITS-1:0] previousState;
    ToggleChannels myToggleChannels(
        .clock(CLK108MHZ),
        .endOfConversion(endOfConversion),
        .DRPReady(DRPReady),
        .DRPDataOut(DRPDataOut[15:4]),
        .DRPEnable(DRPEnable),
        .DRPWriteEnable(DRPWriteEnable),
        .channel1(channel1),
        .channel2(channel2),
        .DRPAddress(DRPAddress),
        .channelDataReady(channelDataReady),
        .state(state),
        .previousState(previousState)
        );
               // ADC controller channel1
      wire adcc_ready;
      wire adccRawReady;
      wire signed [11:0] ADCCdataOutChannel1;
      wire signed [11:0] adccRawDataOutChannel1;
      wire signed [11:0] ADCCdataOutChannel2;
      wire signed [11:0] adccRawDataOutChannel2;

      ADCcontroller adcc(
                             .clock(CLK108MHZ),
                             .reset(reset),
                             .sampleEnabled(1),
                             .inputReady(channelDataReady),
                             .samplePeriod(samplePeriod),
                             .ready(adcc_ready),
                             .rawReady(adccRawReady), // not affected by samplePeriod
                             .dataInChannel1(channel1),
                             .dataOutChannel1(ADCCdataOutChannel1),
                             .rawDataOutChannel1(adccRawDataOutChannel1),
                             .dataInChannel2(channel2),
                             .dataOutChannel2(ADCCdataOutChannel2),
                             .rawDataOutChannel2(adccRawDataOutChannel2)
                             );
                             // edge type detector channel 1
   wire risingEdgeReadyChannel1;
   wire signed [13:0] slopeChannel1;
   wire positiveSlopeChannel1;
    EdgeTypeDetector myEdgeTypeDetectorChannel1
     (.clock(CLK108MHZ),
      .dataReady(adccRawReady),
      .dataIn(adccRawDataOutChannel1),
      .risingEdgeReady(risingEdgeReadyChannel1),
      .estimatedSlope(slopeChannel1),
      .estimatedSlopeIsPositive(positiveSlopeChannel1));
      
    // edge type detector channel 2
    wire risingEdgeReadyChannel2;
    wire signed [13:0] slopeChannel2;
    wire positiveSlopeChannel2;
    EdgeTypeDetector myEdgeTypeDetectorChannel2
        (.clock(CLK108MHZ),
         .dataReady(adccRawReady),
         .dataIn(adccRawDataOutChannel2),
         .risingEdgeReady(risingEdgeReadyChannel2),
         .estimatedSlope(slopeChannel2),
         .estimatedSlopeIsPositive(positiveSlopeChannel2));
         wire drawStarting;
    wire activeBramSelect;
    BufferSelector mybs(
        .clock(CLK108MHZ),
        .drawStarting(drawStarting),
        .activeBramSelect(activeBramSelect)
        );
endmodule
