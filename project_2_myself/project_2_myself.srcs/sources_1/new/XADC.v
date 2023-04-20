`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/18 16:34:35
// Design Name: 
// Module Name: XADC
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





module XADC
          (
          daddr_in,            // Address bus for the dynamic reconfiguration port
          dclk_in,             // Clock input for the dynamic reconfiguration port
          den_in,              // Enable Signal for the dynamic reconfiguration port
          di_in,               // Input data bus for the dynamic reconfiguration port
          dwe_in,              // Write Enable for the dynamic reconfiguration port
          reset_in,            // Reset signal for the System Monitor control logic
          vauxp3,              // Auxiliary channel 3
          vauxn3,
          vauxp11,             // Auxiliary channel 11
          vauxn11,
          busy_out,            // ADC Busy signal
          channel_out,         // Channel Selection Outputs
          do_out,              // Output data bus for dynamic reconfiguration port
          drdy_out,            // Data ready signal for the dynamic reconfiguration port
          eoc_out,             // End of Conversion Signal
          eos_out,             // End of Sequence Signal
          alarm_out,           // OR'ed output of all the Alarms    
          vp_in,               // Dedicated Analog Input Pair
          vn_in);

          input [6:0] daddr_in;
          input dclk_in;
          input den_in;
          input [15:0] di_in;
          input dwe_in;
          input reset_in;
          input vauxp3;
          input vauxn3;
          input vauxp11;
          input vauxn11;
          input vp_in;
          input vn_in;

          output busy_out;
          output [4:0] channel_out;
          output signed [15:0] do_out;
          output drdy_out;
          output eoc_out;
          output eos_out;
          output alarm_out;

        wire FLOAT_VCCAUX;
        wire FLOAT_VCCINT;
        wire FLOAT_TEMP;
          wire GND_BIT;
    wire [2:0] GND_BUS3;
          assign GND_BIT = 0;
    assign GND_BUS3 = 3'b000;
          wire [15:0] aux_channel_p;
          wire [15:0] aux_channel_n;
          wire [7:0]  alm_int;
          assign alarm_out = alm_int[7];
          assign aux_channel_p[0] = 1'b0;
          assign aux_channel_n[0] = 1'b0;

          assign aux_channel_p[1] = 1'b0;
          assign aux_channel_n[1] = 1'b0;

          assign aux_channel_p[2] = 1'b0;
          assign aux_channel_n[2] = 1'b0;

          assign aux_channel_p[3] = vauxp3;
          assign aux_channel_n[3] = vauxn3;

          assign aux_channel_p[4] = 1'b0;
          assign aux_channel_n[4] = 1'b0;

          assign aux_channel_p[5] = 1'b0;
          assign aux_channel_n[5] = 1'b0;

          assign aux_channel_p[6] = 1'b0;
          assign aux_channel_n[6] = 1'b0;

          assign aux_channel_p[7] = 1'b0;
          assign aux_channel_n[7] = 1'b0;

          assign aux_channel_p[8] = 1'b0;
          assign aux_channel_n[8] = 1'b0;

          assign aux_channel_p[9] = 1'b0;
          assign aux_channel_n[9] = 1'b0;

          assign aux_channel_p[10] = 1'b0;
          assign aux_channel_n[10] = 1'b0;

          assign aux_channel_p[11] = vauxp11;
          assign aux_channel_n[11] = vauxn11;

          assign aux_channel_p[12] = 1'b0;
          assign aux_channel_n[12] = 1'b0;

          assign aux_channel_p[13] = 1'b0;
          assign aux_channel_n[13] = 1'b0;

          assign aux_channel_p[14] = 1'b0;
          assign aux_channel_n[14] = 1'b0;

          assign aux_channel_p[15] = 1'b0;
          assign aux_channel_n[15] = 1'b0;
XADC #(
        .INIT_40(16'h8000), // config reg 0
        .INIT_41(16'h410F), // config reg 1
        .INIT_42(16'h0400), // config reg 2
        .INIT_48(16'h0000), // Sequencer channel selection
        .INIT_49(16'h0008), // Sequencer channel selection
        .INIT_4A(16'h0000), // Sequencer Average selection
        .INIT_4B(16'h0000), // Sequencer Average selection
        .INIT_4C(16'h0000), // Sequencer Bipolar selection
        .INIT_4D(16'hFFFF), // Sequencer Bipolar selection, set all auxiliary analog inputs to bipolar mode
        .INIT_4E(16'h0000), // Sequencer Acq time selection
        .INIT_4F(16'h0000), // Sequencer Acq time selection
        .INIT_50(16'hB5ED), // Temp alarm trigger
        .INIT_51(16'h57E4), // Vccint upper alarm limit
        .INIT_52(16'hA147), // Vccaux upper alarm limit
        .INIT_53(16'hCA33),  // Temp alarm OT upper
        .INIT_54(16'hA93A), // Temp alarm reset
        .INIT_55(16'h52C6), // Vccint lower alarm limit
        .INIT_56(16'h9555), // Vccaux lower alarm limit
        .INIT_57(16'hAE4E),  // Temp alarm OT reset
        .INIT_58(16'h5999), // VCCBRAM upper alarm limit
        .INIT_5C(16'h5111),  //  VCCBRAM lower alarm limit
        .SIM_DEVICE("7SERIES"),
        .SIM_MONITOR_FILE("design.txt")
)

inst (
        .CONVST(GND_BIT),
        .CONVSTCLK(GND_BIT),
        .DADDR(daddr_in[6:0]),
        .DCLK(dclk_in),
        .DEN(den_in),
        .DI(di_in[15:0]),
        .DWE(dwe_in),
        .RESET(reset_in),
        .VAUXN(aux_channel_n[15:0]),
        .VAUXP(aux_channel_p[15:0]),
        .ALM(alm_int),
        .BUSY(busy_out),
        .CHANNEL(channel_out[4:0]),
        .DO(do_out[15:0]),
        .DRDY(drdy_out),
        .EOC(eoc_out),
        .EOS(eos_out),
        .JTAGBUSY(),
        .JTAGLOCKED(),
        .JTAGMODIFIED(),
        .OT(),
        .MUXADDR(),
        .VP(vp_in),
        .VN(vn_in)
          );

endmodule
