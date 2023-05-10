`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/10 18:57:54
// Design Name: 
// Module Name: osc_tb
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


module osc_tb(
    );
    reg CLK100MHZ;
    reg [15:0] SW;
    reg BTNU;
    reg BTND;
    reg BTNC;
    reg BTNL;
    wire hsync;
    wire vsync;
    wire [11:0] rgb;

    oscilloscope u_oscilloscope(
        .CLK100MHZ (CLK100MHZ ),
        .vauxp11   (1'b0      ),
        .vauxn11   (1'b0      ),
        .vauxp3    (1'b0      ),
        .vauxn3    (1'b0      ),
        .SW        (SW        ),
        .BTNU      (BTNU      ),
        .BTND      (BTND      ),
        .BTNC      (BTNC      ),
        .BTNL      (BTNL      ),
        .hsync     (hsync     ),
        .vsync     (vsync     ),
        .rgb       (rgb       )
    );

    initial begin
        CLK100MHZ = 0;
        SW = 16'b0;
        BTNU = 0;
        BTND = 0;
        BTNC = 0;
        BTNL = 0;
    end

    always begin
        #1 CLK100MHZ = ~CLK100MHZ;
    end



endmodule
