`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 18:59:43
// Design Name: 
// Module Name: display_tb
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


module display_tb;


    // Inputs
    reg clk;
    reg reset;
    reg [`DATA_IN_BITS - 1:0] data_in;
    reg [`SCALE_BITS - 1:0] scale_exp;
    
    // Outputs
    wire hsync;
    wire vsync;
    wire [`RGB_BITS - 1:0] rgb;
    wire [`DATA_ADDRESS_BITS - 1:0] data_address;

    // Instantiate the Unit Under Test (UUT)
    display u_display(
    	.clk          (clk          ),
        .reset        (reset        ),
        .data_in      (data_in      ),
        .scale_exp    (scale_exp    ),
        .hsync        (hsync        ),
        .vsync        (vsync        ),
        .rgb          (rgb          ),
        .data_address (data_address )
    );

    initial begin
        clk = 0;
        reset = 1;
        data_in = 0;
        scale_exp = 8;
        #10;
        reset = 0;
        #10;
        reset = 1;
        #4000000;
        $finish;
    end

    always #1 clk = ~clk;

    always @(posedge clk) begin
        if (data_in < 255) begin
            data_in = data_in + 1;
        end
        else begin
            data_in = 0;
        end
    end
    
endmodule

