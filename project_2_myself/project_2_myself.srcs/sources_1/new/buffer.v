`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/20 16:02:27
// Design Name: 
// Module Name: buffer
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


module buffer #(parameter LOG_SAMPLES=12, SAMPLE_SIZE=12)
              (input clock, input ready, input signed [SAMPLE_SIZE-1:0]dataIn,
               input isTrigger, input disableCollection, input activeBramSelect, // 0 if BRAM 0 is active
               input reset,
               input readTriggerRelative,
               input signed [LOG_SAMPLES-1:0]readAddress,
               output reg signed [SAMPLE_SIZE-1:0]dataOut);

    reg [LOG_SAMPLES-1:0] pointer0; // points to the next open slot in the BRAM    
    reg [LOG_SAMPLES-1:0] trigger_address0;  
    wire [LOG_SAMPLES-1:0] addressAllOnes;
    assign addressAllOnes = 'hFFFFFFFFFFF; // more one bits than allOnes will possibly need

    // Need the IP for this
    reg ram0_we;
    reg [LOG_SAMPLES-1:0] ram0_addra;
    reg [SAMPLE_SIZE-1:0] ram0_din;
    reg [LOG_SAMPLES-1:0] ram0_addrb;
    wire [SAMPLE_SIZE-1:0] ram0_dout;
    
    blk_mem_gen_0 bram0 (
      .clka(clock),    // input wire clka
      .ena(1),      // input wire ena
      .wea(ram0_we),      // input wire [0 : 0] wea
      .addra(ram0_addra),  // input wire [9 : 0] addra
      .dina(ram0_din),    // input wire [11 : 0] dina
      .douta(),  // output wire [11 : 0] douta
      .clkb(clock),    // input wire clkb
      .enb(1),      // input wire enb
      .web(0),      // input wire [0 : 0] web
      .addrb(ram0_addrb),  // input wire [9 : 0] addrb
      .dinb(),    // input wire [11 : 0] dinb
      .doutb(ram0_dout)  // output wire [11 : 0] doutb
    );
  
  always @(posedge clock) begin
    if (reset) begin
      trigger_address0 <= 0;   
      pointer0 <= 0;
    
    end else begin
      if (ready && !disableCollection) begin
        // store dataIn to pointer
        ram0_addra <= pointer0;     
        ram0_din <= dataIn;
 
        // only write to the active BRAM
        if (activeBramSelect == 0) begin
          ram0_we <= 1;        
          pointer0 <= pointer0 + 1;
        end 
      end
      
      // trigger can fire at any time, even when data isn't ready
      if (isTrigger && !disableCollection) begin
        if (activeBramSelect == 0) begin
          trigger_address0 <= pointer0;
        end 
      end

      // read data
      if (readTriggerRelative) begin
        ram0_addrb <= (trigger_address0 + readAddress) & addressAllOnes;      
      end else begin
        ram0_addrb <= (pointer0 + readAddress) & addressAllOnes;
      end

      // the bram we actually output is the locked (non-active) one
      if (activeBramSelect == 1)
        dataOut <= ram0_dout;
        end
        end
        endmodule