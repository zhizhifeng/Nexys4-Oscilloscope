`timescale 1ns / 1ps
`include "../../sources_1/new/display.vh"
module display_tb;
    // Inputs
    reg clk;
    reg reset;
    reg trigger_channel;
    reg xy_enable;
    reg [`DATA_IN_BITS - 1:0] data_in_1;
    reg [`DATA_IN_BITS - 1:0] data_in_2;
    reg [`H_SCALE_BITS - 1:0] h_scale;
    reg [`V_SCALE_BITS - 1:0] v_scale_1;
    reg [`V_SCALE_BITS - 1:0] v_scale_2;
    reg [`DATA_IN_BITS - 1:0] data_in_1_max;
    reg [`DATA_IN_BITS - 1:0] data_in_2_max;
    reg [`DATA_IN_BITS - 1:0] data_in_1_min;
    reg [`DATA_IN_BITS - 1:0] data_in_2_min;
    reg [`DATA_IN_BITS - 1:0] tri_threshold;

    // Outputs
    wire refresh;
    wire hsync;
    wire vsync;
    wire [`RGB_BITS - 1:0] rgb;
    wire [`DATA_ADDRESS_BITS - 1:0] data_address;

    // Instantiate the Unit Under Test (UUT)
    display u_display(
    	.clk             (clk             ),
        .reset           (reset           ),
        .trigger_channel (trigger_channel ),
        .xy_enable       (xy_enable       ),
        .data_in_1       (data_in_1       ),
        .data_in_2       (data_in_2       ),
        .h_scale         (h_scale         ),
        .v_scale_1       (v_scale_1       ),
        .v_scale_2       (v_scale_2       ),
        .data_in_1_max   (data_in_1_max   ),
        .data_in_2_max   (data_in_2_max   ),
        .data_in_1_min   (data_in_1_min   ),
        .data_in_2_min   (data_in_2_min   ),
        .tri_threshold   (tri_threshold   ),
        .refresh         (refresh         ),
        .hsync_out       (hsync           ),
        .vsync_out       (vsync           ),
        .rgb             (rgb             ),
        .data_address    (data_address    )
    );
    
    initial begin
        clk = 0;
        reset = 1;
        trigger_channel = 1;
        xy_enable = 1;
        data_in_1 = 0;
        data_in_2 = 0;
        h_scale = 1;
        v_scale_1 = 0;
        v_scale_2 = 0;
        data_in_1_max = 12'b001010101010;
        data_in_2_max = 12'b001010101010;
        data_in_1_min = 12'b101010101010;
        data_in_2_min = 12'b101010101010;
        tri_threshold = 0;
        #10;
        reset = 0;
        #10;
        reset = 1;
        #40000000;
        $finish;
    end

    always #1 clk = ~clk;

    always @(posedge clk) begin
        if (data_in_1 < 300) begin
            data_in_1 = data_in_1 + 1;
            data_in_2 = data_in_2 + 1;
        end
        else begin
            data_in_1 = 0;
            data_in_2 = 0;
        end
    end
    
endmodule
