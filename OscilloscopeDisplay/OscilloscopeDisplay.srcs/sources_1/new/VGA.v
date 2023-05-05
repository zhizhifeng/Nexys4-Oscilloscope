`timescale 1ns / 1ps
// Input/Output Ports:
// Input:
// pclk - varies depending on the TYPE
// reset - high-level logic

// Output:
// hsync - Horizontal sync timing signal
// vsync - Vertical sync timing signal
// valid - viewable (or active) video 
// h_cnt[10:0] -  current horizontal position of a pixel
// v_cnt[10:0] -  current vertical position of a pixel

module VGA #(
    parameter [1:0] TYPE = 0
 )
 (
    input wire pclk,reset,
    output wire hsync,vsync,valid,
    output wire [10:0]h_cnt,
    output wire [9:0]v_cnt
    );
    
    reg [10:0]pixel_cnt;
    reg [10:0]line_cnt;
    reg hsync_i, vsync_i, hsync_default, vsync_default;
    integer HD, HF, HA, HB, HT, VD, VF, VA, VB, VT;
    
    always @(posedge pclk)
    case(TYPE)
        2'b00: begin    //VESA 1280x1024@60 Hz (pixel clock 108.0 MHz)
            HD <= 1280;    //horizontal display width
            HF <= 48;      //horizontal front porch
            HA <= 112;     //horizontal active
            HB <= 248;     //horizontal back porch
            HT <= 1688;    //horizontal total
            VD <= 1024;    //vertical display width
            VF <= 1;       //vertical front porch
            VA <= 3;       //vertical active
            VB <= 38;      //vertical back porch
            VT <= 1066;    //vertical total
            hsync_default <= 1'b0;
            vsync_default <= 1'b0;
        end
        default: begin
            HD <= 640;
            HF <= 16;
            HA <= 96;
            HB <= 48;
            HT <= 800;
            VD <= 480;
            VF <= 10;
            VA <= 2;
            VB <= 33;
            VT <= 525;      
            hsync_default <= 1'b1;
            vsync_default <= 1'b1;       
        end
    endcase

    // horizontal counter
    always@(posedge pclk)
        if(!reset)
            pixel_cnt <= 0;
        else if(pixel_cnt < (HT - 1))
            pixel_cnt <= pixel_cnt + 1;
        else
            pixel_cnt <= 0;

    // horizontal sync
    always@(posedge pclk)
        if(!reset)
            hsync_i <= hsync_default;
        else if((pixel_cnt >= (HD + HF - 1))&&(pixel_cnt < (HD + HF + HA - 1)))
            hsync_i <= ~hsync_default;
        else
            hsync_i <= hsync_default; 
    
    // vertical counter
    always@(posedge pclk)
        if(!reset)
            line_cnt <= 0;
        else if(pixel_cnt == (HT -1))
            if(line_cnt < (VT - 1))
                line_cnt <= line_cnt + 1;
            else
                line_cnt <= 0;

    // vertical sync
    always@(posedge pclk)
        if(!reset)
            vsync_i <= vsync_default; 
        else if((line_cnt >= (VD + VF - 1))&&(line_cnt < (VD + VF + VA - 1)))
            vsync_i <= ~vsync_default; 
        else
            vsync_i <= vsync_default; 
                    
    assign hsync = hsync_i;
    assign vsync = vsync_i;
    assign valid = ((pixel_cnt < HD) && (line_cnt < VD));
    
    assign h_cnt = (pixel_cnt < HD) ? pixel_cnt:11'd0;
    assign v_cnt = (line_cnt < VD) ? line_cnt[9:0]:10'd0;
           
endmodule
