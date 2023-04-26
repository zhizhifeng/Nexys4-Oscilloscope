`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/25 21:03:04
// Design Name: 
// Module Name: ADC
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


module ADC
 #(parameter IO_BITS = 12, SAMPLE_BITS = 12,
                TOGGLE_CHANNELS_STATE_BITS = 2 ,DRP_ADDRESS_BITS = 7,
                DRP_SAMPLE_BITS = 16)
(
input vauxp11,
   input vauxn11,
   input vauxp3,
   input vauxn3,
   input clk,
   input reset,
   input vp_in,
   input vn_in,
   input di_in,
   input daddr_in,
   input den_in,
   input dwe_in,
   input sampleperiod,
   input channel1,
     input channel2,
     input channelDataReady,
     input [TOGGLE_CHANNELS_STATE_BITS-1:0] state,
     input [TOGGLE_CHANNELS_STATE_BITS-1:0] previousState,
     input adcc_ready,
       input adccRawReady,
      input signed [11:0] ADCCdataOutChannel1,
      input signed [11:0] adccRawDataOutChannel1,
       input signed [11:0] ADCCdataOutChannel2,
       input signed [11:0] adccRawDataOutChannel2,
   output reg ready,
    output reg rawReady, 
    output reg signed[IO_BITS-1:0] dataOutChannel1,
    output reg signed[IO_BITS-1:0] rawDataOutChannel1,
    output reg signed[IO_BITS-1:0] dataOutChannel2,
    output reg signed[IO_BITS-1:0] rawDataOutChannel2
    );
     wire [DRP_ADDRESS_BITS-1:0] DRPAddress;
    wire DRPEnable;
    wire DRPWriteEnable;
    wire DRPReady;
    wire signed [DRP_SAMPLE_BITS-1:0] DRPDataOut;
    wire endOfConversion;
    
  xadc_wiz_0 xadc (
        .di_in(),                       
        .daddr_in(DRPAddress),          
        .den_in(DRPEnable),             
        .dwe_in(DRPWriteEnable),        
        .drdy_out(DRPReady),           
        .do_out(DRPDataOut),            
        .dclk_in(clk),            
        .reset_in(reset),               
        .vp_in(),                       
        .vn_in(),                       
        .vauxp3(vauxp3),                
        .vauxn3(vauxn3),                
        .vauxp11(vauxp11),              
        .vauxn11(vauxn11),              
        .channel_out(),                 
        .eoc_out(endOfConversion),     
        .alarm_out(),                  
        .eos_out(),                    
        .busy_out()                     
        );
       
    ToggleChannels myToggleChannels(
        .clock(clk),
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
               
      

      ADCcontroller adcc(
                             .clock(clk),
                             .reset(reset),
                             .sampleEnabled(1),
                             .inputReady(channelDataReady),
                             .samplePeriod(samplePeriod),
                             .ready(adcc_ready),
                             .rawReady(adccRawReady), 
                             .dataInChannel1(channel1),
                             .dataOutChannel1(ADCCdataOutChannel1),
                             .rawDataOutChannel1(adccRawDataOutChannel1),
                             .dataInChannel2(channel2),
                             .dataOutChannel2(ADCCdataOutChannel2),
                             .rawDataOutChannel2(adccRawDataOutChannel2)
                             );
endmodule
