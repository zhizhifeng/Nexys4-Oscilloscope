`timescale 1ns / 1ps

module buffer #(parameter LOG_SAMPLES = 12,
                SAMPLE_SIZE = 12)
               (input clock,
                input ready,
                input signed [SAMPLE_SIZE-1:0]dataIn,
                input isTrigger,
                input disableCollection,
                input activeBramSelect,
                input reset,
                input readTriggerRelative,
                input signed [LOG_SAMPLES-1:0]readAddress,
                output reg signed [SAMPLE_SIZE-1:0]dataOut);
    
    reg [LOG_SAMPLES-1:0] pointer0         = 0;
    reg [LOG_SAMPLES-1:0] pointer1         = 0;
    reg [LOG_SAMPLES-1:0] trigger_address0 = 0;
    reg [LOG_SAMPLES-1:0] trigger_address1 = 0;
    
    wire [LOG_SAMPLES-1:0] addressAllOnes;
    assign addressAllOnes = 'hFFFFFFFFFFF;

    reg ram0_we                      = 0;
    reg [LOG_SAMPLES-1:0] ram0_addra = 0;
    reg [SAMPLE_SIZE-1:0] ram0_din   = 0;
    reg [LOG_SAMPLES-1:0] ram0_addrb = 0;
    wire [SAMPLE_SIZE-1:0] ram0_dout;
    
    blk_mem_gen_0 bram0 (
    .clka(clock),
    .ena(1),
    .wea(ram0_we),
    .addra(ram0_addra),
    .dina(ram0_din),
    .douta(),
    .clkb(clock),
    .enb(1),
    .web(0),
    .addrb(ram0_addrb),
    .dinb(),
    .doutb(ram0_dout)
    );
    
    reg ram1_we                      = 0;
    reg [LOG_SAMPLES-1:0] ram1_addra = 0;
    reg [SAMPLE_SIZE-1:0] ram1_din   = 0;
    reg [LOG_SAMPLES-1:0] ram1_addrb = 0;
    wire [SAMPLE_SIZE-1:0] ram1_dout;

    blk_mem_gen_1 bram1 (
    .clka(clock),
    .ena(1),
    .wea(ram1_we),
    .addra(ram1_addra),
    .dina(ram1_din),
    .douta(),
    .clkb(clock),
    .enb(1),
    .web(0),
    .addrb(ram1_addrb),
    .dinb(),
    .doutb(ram1_dout)
    );
    
    always @(posedge clock) begin
        if (reset) begin
            trigger_address0 <= 0;
            trigger_address1 <= 0;
            
            pointer0 <= 0;
            pointer1 <= 0;
            
        end else begin
            if (ready && !disableCollection) begin
                
                ram0_addra <= pointer0;
                ram1_addra <= pointer1;
                ram0_din   <= dataIn;
                ram1_din   <= dataIn;
                
                
                if (activeBramSelect == 0) begin
                    ram0_we  <= 1;
                    ram1_we  <= 0;
                    pointer0 <= pointer0 + 1;
                    end else begin
                    ram0_we  <= 0;
                    ram1_we  <= 1;
                    pointer1 <= pointer1 + 1;
                end
            end
            
            
            if (isTrigger && !disableCollection) begin
                if (activeBramSelect == 0) begin
                    trigger_address0 <= pointer0;
                    end else begin
                    trigger_address1 <= pointer1;
                end
            end
            
            
            if (readTriggerRelative) begin
                ram0_addrb <= (trigger_address0 + readAddress) & addressAllOnes;
                ram1_addrb <= (trigger_address1 + readAddress) & addressAllOnes;
                end else begin
                ram0_addrb <= (pointer0 + readAddress) & addressAllOnes;
                ram1_addrb <= (pointer1 + readAddress) & addressAllOnes;
            end
            
            
            if (activeBramSelect == 0)
                dataOut <= ram1_dout;
            else
                dataOut <= ram0_dout;
        end
    end
endmodule
