`timescale 1ns / 1ps
`include "display.vh"

module infoDisplay (input clk,
                    input trigger_channel,
                    input [`H_SCALE_BITS - 1:0] h_scale,
                    input [`V_SCALE_BITS - 1:0] v_scale_1,
                    input [`V_SCALE_BITS - 1:0] v_scale_2,
                    input signed [`DATA_IN_BITS - 1:0] data_in_1_max,
                    input signed [`DATA_IN_BITS - 1:0] data_in_2_max,
                    input signed [`DATA_IN_BITS - 1:0] data_in_1_min,
                    input signed [`DATA_IN_BITS - 1:0] data_in_2_min,
                    input signed [`DATA_IN_BITS - 1:0] tri_threshold,
                    input [`DISPLAY_X_BITS - 1:0] x_cnt,
                    input [`DISPLAY_Y_BITS - 1:0] y_cnt,
                    input [`RGB_BITS - 1:0] pre_rgb,
                    output [`RGB_BITS - 1:0] rgb_out,
                    output info_valid);
    
    wire data_in_1_max_sign;
    wire [15:0] data_in_1_max_bcd;
    
    binarytoBCD u_binarytoBCD_1(
    .bin_in (data_in_1_max),
    .sign   (data_in_1_max_sign),
    .bcd    (data_in_1_max_bcd)
    );
    
    wire data_in_1_min_sign;
    wire [15:0] data_in_1_min_bcd;
    
    binarytoBCD u_binarytoBCD_2(
    .bin_in (data_in_1_min),
    .sign   (data_in_1_min_sign),
    .bcd    (data_in_1_min_bcd)
    );
    
    wire data_in_2_max_sign;
    wire [15:0] data_in_2_max_bcd;
    
    binarytoBCD u_binarytoBCD_3(
    .bin_in (data_in_2_max),
    .sign   (data_in_2_max_sign),
    .bcd    (data_in_2_max_bcd)
    );

    wire data_in_2_min_sign;
    wire [15:0] data_in_2_min_bcd;

    binarytoBCD u_binarytoBCD_4(
    .bin_in (data_in_2_min),
    .sign   (data_in_2_min_sign),
    .bcd    (data_in_2_min_bcd)
    );

    wire tri_threshold_sign;
    wire [15:0] tri_threshold_bcd;

    binarytoBCD u_binarytoBCD_5(
    .bin_in (tri_threshold),
    .sign   (tri_threshold_sign),
    .bcd    (tri_threshold_bcd)
    );

    wire h_scale_sign;
    wire [15:0] h_scale_bcd;

    binarytoBCD u_binarytoBCD(
    	.bin_in (h_scale + 1 ),
        .sign   (h_scale_sign   ),
        .bcd    (h_scale_bcd    )
    );

    wire [`CHAR_BITS - 1:0] v_1_char_1;
    wire [`CHAR_BITS - 1:0] v_1_char_2;
    wire [`CHAR_BITS - 1:0] v_1_char_3;
    wire [`CHAR_BITS - 1:0] v_1_char_4;
    wire [`CHAR_BITS - 1:0] v_1_char_5;
    
    wire [`CHAR_BITS - 1:0] v_2_char_1;
    wire [`CHAR_BITS - 1:0] v_2_char_2;
    wire [`CHAR_BITS - 1:0] v_2_char_3;
    wire [`CHAR_BITS - 1:0] v_2_char_4;
    wire [`CHAR_BITS - 1:0] v_2_char_5;
    
    verticaltoDecimal u_verticaltoDecimal_1(
    .v_scale  (v_scale_1),
    .v_char_1 (v_1_char_1),
    .v_char_2 (v_1_char_2),
    .v_char_3 (v_1_char_3),
    .v_char_4 (v_1_char_4),
    .v_char_5 (v_1_char_5)
    );

    verticaltoDecimal u_verticaltoDecimal_2(
    .v_scale  (v_scale_2),
    .v_char_1 (v_2_char_1),
    .v_char_2 (v_2_char_2),
    .v_char_3 (v_2_char_3),
    .v_char_4 (v_2_char_4),
    .v_char_5 (v_2_char_5)
    );

    parameter NUM_CHARS = 64; // total number of characters
    wire [`DISPLAY_X_BITS - 1:0] x_positions [NUM_CHARS-1:0];
    wire [`DISPLAY_Y_BITS - 1:0] y_positions [NUM_CHARS-1:0];
    wire [`RGB_BITS - 1:0] rgbs [NUM_CHARS-1:0];
    wire [`CHAR_BITS-1:0] char_datas [NUM_CHARS-1:0];

    //CH1 CHARACTERS
    assign {x_positions[0], y_positions[0], rgbs[0], char_datas[0]} = {11'd0 + `EX_CONST_1, 10'd1007, `YELLOW, `CHAR_C};
    assign {x_positions[1], y_positions[1], rgbs[1], char_datas[1]} = {11'd14 + `EX_CONST_1, 10'd1007, `YELLOW, `CHAR_H};
    assign {x_positions[2], y_positions[2], rgbs[2], char_datas[2]} = {11'd28 + `EX_CONST_1, 10'd1007, `YELLOW, `CHAR_1};
    //CH1 VERTICAL SCALE
    assign {x_positions[3], y_positions[3], rgbs[3], char_datas[3]} = {11'd56 + `EX_CONST_1, 10'd1007, `WHITE, v_1_char_1};
    assign {x_positions[4], y_positions[4], rgbs[4], char_datas[4]} = {11'd70 + `EX_CONST_1, 10'd1007, `WHITE, v_1_char_2};
    assign {x_positions[5], y_positions[5], rgbs[5], char_datas[5]} = {11'd84 + `EX_CONST_1, 10'd1007, `WHITE, v_1_char_3};
    assign {x_positions[6], y_positions[6], rgbs[6], char_datas[6]} = {11'd98 + `EX_CONST_1, 10'd1007, `WHITE, v_1_char_4};
    assign {x_positions[7], y_positions[7], rgbs[7], char_datas[7]} = {11'd112 + `EX_CONST_1, 10'd1007, `WHITE, v_1_char_5};
    assign {x_positions[8], y_positions[8], rgbs[8], char_datas[8]} = {11'd126 + `EX_CONST_1, 10'd1007, `WHITE, `CHAR_m};
    assign {x_positions[9], y_positions[9], rgbs[9], char_datas[9]} = {11'd140 + `EX_CONST_1, 10'd1007, `WHITE, `CHAR_V};
    //CH1 MAX & MIN
    assign {x_positions[10], y_positions[10], rgbs[10], char_datas[10]} = {11'd168 + `EX_CONST_1, 10'd1007, `WHITE, data_in_1_max_sign ? `CHAR_MINUS : `CHAR_PLUS};
    assign {x_positions[11], y_positions[11], rgbs[11], char_datas[11]} = {11'd182 + `EX_CONST_1, 10'd1007, `WHITE, {3'h1, data_in_1_max_bcd[11:8]}};
    assign {x_positions[12], y_positions[12], rgbs[12], char_datas[12]} = {11'd196 + `EX_CONST_1, 10'd1007, `WHITE, {3'h1, data_in_1_max_bcd[7:4]}};
    assign {x_positions[13], y_positions[13], rgbs[13], char_datas[13]} = {11'd210 + `EX_CONST_1, 10'd1007, `WHITE, {3'h1, data_in_1_max_bcd[3:0]}};
    assign {x_positions[14], y_positions[14], rgbs[14], char_datas[14]} = {11'd224 + `EX_CONST_1, 10'd1007, `WHITE, `CHAR_m};
    assign {x_positions[15], y_positions[15], rgbs[15], char_datas[15]} = {11'd238 + `EX_CONST_1, 10'd1007, `WHITE, `CHAR_V};
    assign {x_positions[16], y_positions[16], rgbs[16], char_datas[16]} = {11'd252 + `EX_CONST_1, 10'd1007, `WHITE, `CHAR_SLASH};
    assign {x_positions[17], y_positions[17], rgbs[17], char_datas[17]} = {11'd266 + `EX_CONST_1, 10'd1007, `WHITE, data_in_1_min_sign ? `CHAR_MINUS : `CHAR_PLUS};
    assign {x_positions[18], y_positions[18], rgbs[18], char_datas[18]} = {11'd280 + `EX_CONST_1, 10'd1007, `WHITE, {3'h1, data_in_1_min_bcd[11:8]}};
    assign {x_positions[19], y_positions[19], rgbs[19], char_datas[19]} = {11'd294 + `EX_CONST_1, 10'd1007, `WHITE, {3'h1, data_in_1_min_bcd[7:4]}};
    assign {x_positions[20], y_positions[20], rgbs[20], char_datas[20]} = {11'd308 + `EX_CONST_1, 10'd1007, `WHITE, {3'h1, data_in_1_min_bcd[3:0]}};
    assign {x_positions[21], y_positions[21], rgbs[21], char_datas[21]} = {11'd322 + `EX_CONST_1, 10'd1007, `WHITE, `CHAR_m};
    assign {x_positions[22], y_positions[22], rgbs[22], char_datas[22]} = {11'd336 + `EX_CONST_1, 10'd1007, `WHITE, `CHAR_V};
    //CH2 CHARACTERS
    assign {x_positions[23], y_positions[23], rgbs[23], char_datas[23]} = {11'd364 + `EX_CONST_1, 10'd1007, `CYAN, `CHAR_C};
    assign {x_positions[24], y_positions[24], rgbs[24], char_datas[24]} = {11'd378 + `EX_CONST_1, 10'd1007, `CYAN, `CHAR_H};
    assign {x_positions[25], y_positions[25], rgbs[25], char_datas[25]} = {11'd392 + `EX_CONST_1, 10'd1007, `CYAN, `CHAR_2};
    //CH2 VERTICAL SCALE
    assign {x_positions[26], y_positions[26], rgbs[26], char_datas[26]} = {11'd420 + `EX_CONST_1, 10'd1007, `WHITE, v_2_char_1};
    assign {x_positions[27], y_positions[27], rgbs[27], char_datas[27]} = {11'd434 + `EX_CONST_1, 10'd1007, `WHITE, v_2_char_2};
    assign {x_positions[28], y_positions[28], rgbs[28], char_datas[28]} = {11'd448 + `EX_CONST_1, 10'd1007, `WHITE, v_2_char_3};
    assign {x_positions[29], y_positions[29], rgbs[29], char_datas[29]} = {11'd462 + `EX_CONST_1, 10'd1007, `WHITE, v_2_char_4};
    assign {x_positions[30], y_positions[30], rgbs[30], char_datas[30]} = {11'd476 + `EX_CONST_1, 10'd1007, `WHITE, v_2_char_5};
    assign {x_positions[31], y_positions[31], rgbs[31], char_datas[31]} = {11'd490 + `EX_CONST_1, 10'd1007, `WHITE, `CHAR_m};
    assign {x_positions[32], y_positions[32], rgbs[32], char_datas[32]} = {11'd504 + `EX_CONST_1, 10'd1007, `WHITE, `CHAR_V};
    //CH2 MAX & MIN
    assign {x_positions[33], y_positions[33], rgbs[33], char_datas[33]} = {11'd532 + `EX_CONST_1, 10'd1007, `WHITE, data_in_2_max_sign ? `CHAR_MINUS : `CHAR_PLUS};
    assign {x_positions[34], y_positions[34], rgbs[34], char_datas[34]} = {11'd546 + `EX_CONST_1, 10'd1007, `WHITE, {3'h1, data_in_2_max_bcd[11:8]}};
    assign {x_positions[35], y_positions[35], rgbs[35], char_datas[35]} = {11'd560 + `EX_CONST_1, 10'd1007, `WHITE, {3'h1, data_in_2_max_bcd[7:4]}};
    assign {x_positions[36], y_positions[36], rgbs[36], char_datas[36]} = {11'd574 + `EX_CONST_1, 10'd1007, `WHITE, {3'h1, data_in_2_max_bcd[3:0]}};
    assign {x_positions[37], y_positions[37], rgbs[37], char_datas[37]} = {11'd588 + `EX_CONST_1, 10'd1007, `WHITE, `CHAR_m};
    assign {x_positions[38], y_positions[38], rgbs[38], char_datas[38]} = {11'd602 + `EX_CONST_1, 10'd1007, `WHITE, `CHAR_V};
    assign {x_positions[39], y_positions[39], rgbs[39], char_datas[39]} = {11'd616 + `EX_CONST_1, 10'd1007, `WHITE, `CHAR_SLASH};
    assign {x_positions[40], y_positions[40], rgbs[40], char_datas[40]} = {11'd630 + `EX_CONST_1, 10'd1007, `WHITE, data_in_2_min_sign ? `CHAR_MINUS : `CHAR_PLUS};
    assign {x_positions[41], y_positions[41], rgbs[41], char_datas[41]} = {11'd644 + `EX_CONST_1, 10'd1007, `WHITE, {3'h1, data_in_2_min_bcd[11:8]}};
    assign {x_positions[42], y_positions[42], rgbs[42], char_datas[42]} = {11'd658 + `EX_CONST_1, 10'd1007, `WHITE, {3'h1, data_in_2_min_bcd[7:4]}};
    assign {x_positions[43], y_positions[43], rgbs[43], char_datas[43]} = {11'd672 + `EX_CONST_1, 10'd1007, `WHITE, {3'h1, data_in_2_min_bcd[3:0]}};
    assign {x_positions[44], y_positions[44], rgbs[44], char_datas[44]} = {11'd686 + `EX_CONST_1, 10'd1007, `WHITE, `CHAR_m};
    assign {x_positions[45], y_positions[45], rgbs[45], char_datas[45]} = {11'd700 + `EX_CONST_1, 10'd1007, `WHITE, `CHAR_V};
    //HORIZONAL SCALE
    assign {x_positions[46], y_positions[46], rgbs[46], char_datas[46]} = {11'd742 + `EX_CONST_1, 10'd1007, `WHITE, {3'h1, h_scale_bcd[11:8]}};
    assign {x_positions[47], y_positions[47], rgbs[47], char_datas[47]} = {11'd756 + `EX_CONST_1, 10'd1007, `WHITE, {3'h1, h_scale_bcd[7:4]}};
    assign {x_positions[48], y_positions[48], rgbs[48], char_datas[48]} = {11'd770 + `EX_CONST_1, 10'd1007, `WHITE, `CHAR_PERIOD};
    assign {x_positions[49], y_positions[49], rgbs[49], char_datas[49]} = {11'd784 + `EX_CONST_1, 10'd1007, `WHITE, {3'h1, h_scale_bcd[3:0]}};
    assign {x_positions[50], y_positions[50], rgbs[50], char_datas[50]} = {11'd798 + `EX_CONST_1, 10'd1007, `WHITE, `CHAR_m};
    assign {x_positions[51], y_positions[51], rgbs[51], char_datas[51]} = {11'd812 + `EX_CONST_1, 10'd1007, `WHITE, `CHAR_s};
    //TRI CHARACTERS
    assign {x_positions[52], y_positions[52], rgbs[52], char_datas[52]} = {11'd854 + `EX_CONST_1, 10'd1007, `WHITE, `CHAR_T};
    assign {x_positions[53], y_positions[53], rgbs[53], char_datas[53]} = {11'd868 + `EX_CONST_1, 10'd1007, `WHITE, `CHAR_R};
    assign {x_positions[54], y_positions[54], rgbs[54], char_datas[54]} = {11'd882 + `EX_CONST_1, 10'd1007, `WHITE, `CHAR_I};
    //TRI CHANNEL
    assign {x_positions[55], y_positions[55], rgbs[55], char_datas[55]} = {11'd910 + `EX_CONST_1, 10'd1007, `WHITE, `CHAR_C};
    assign {x_positions[56], y_positions[56], rgbs[56], char_datas[56]} = {11'd924 + `EX_CONST_1, 10'd1007, `WHITE, `CHAR_H};
    assign {x_positions[57], y_positions[57], rgbs[57], char_datas[57]} = {11'd938 + `EX_CONST_1, 10'd1007, `WHITE, trigger_channel ? `CHAR_2 : `CHAR_1};
    //TRI THRESHOLD
    assign {x_positions[58], y_positions[58], rgbs[58], char_datas[58]} = {11'd966 + `EX_CONST_1, 10'd1007, `WHITE, tri_threshold_sign ? `CHAR_MINUS : `CHAR_PLUS};
    assign {x_positions[59], y_positions[59], rgbs[59], char_datas[59]} = {11'd980 + `EX_CONST_1, 10'd1007, `WHITE, {3'h1, tri_threshold_bcd[11:8]}};
    assign {x_positions[60], y_positions[60], rgbs[60], char_datas[60]} = {11'd994 + `EX_CONST_1, 10'd1007, `WHITE, {3'h1, tri_threshold_bcd[7:4]}};
    assign {x_positions[61], y_positions[61], rgbs[61], char_datas[61]} = {11'd1008 + `EX_CONST_1, 10'd1007, `WHITE, {3'h1, tri_threshold_bcd[3:0]}};
    assign {x_positions[62], y_positions[62], rgbs[62], char_datas[62]} = {11'd1022 + `EX_CONST_1, 10'd1007, `WHITE, `CHAR_m};
    assign {x_positions[63], y_positions[63], rgbs[63], char_datas[63]} = {11'd1036 + `EX_CONST_1, 10'd1007, `WHITE, `CHAR_V};
    
    
    
    integer i;
    
    reg [`RGB_BITS - 1:0] rgb;
    reg [`CHAR_Y_BITS - 1:0] row_addr;
    reg [`CHAR_X_BITS - 1:0] col_addr;
    reg [`CHAR_BITS-1:0] char_data;
    reg char_valid;
    
    always @ (*) begin
        if (x_cnt == 0 && y_cnt == 0)
            char_valid <= 1'b0;
        
        for (i = 0; i < NUM_CHARS; i = i + 1) begin
            if (x_positions[i] <= x_cnt && x_cnt < (x_positions[i] + `CHAR_X_LEN) &&
            y_positions[i] <= y_cnt && y_cnt < (y_positions[i] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[i];
            row_addr   <= y_cnt - y_positions[i];
            char_data  <= char_datas[i];
            rgb        <= rgbs[i];
        end
        // else begin
        //     char_valid <= char_valid;
        //     col_addr   <= col_addr;
        //     row_addr   <= row_addr;
        //     char_data  <= char_data;
        //     rgb        <= rgb;
        // end
    end
    end
    
    /*
     wire [`CHAR_Y_BITS - 1:0] row_addrs [NUM_CHARS-1:0];
     wire [`CHAR_X_BITS - 1:0] col_addrs [NUM_CHARS-1:0];
     wire [`CHAR_BITS - 1:0] char_data_outs [NUM_CHARS-1:0];
     wire [`RGB_BITS-1:0] rgb_outs [NUM_CHARS-1:0];
     wire char_valids [NUM_CHARS-1:0];
     
     charDisplay u_charDisplay_0(
     .rgb(rgbs[0]),
     .x_cnt         (x_cnt),
     .y_cnt         (y_cnt),
     .x_position    (x_positions[0]),
     .y_position    (y_positions[0]),
     .char_data     (char_datas[0]),
     .pre_char_data (0),
     .pre_rgb       (0),
     .pre_row_addr  (row_addrs[0]),
     .pre_col_addr  (0),
     .char_valid    (char_valids[0]),
     .row_addr_out  (row_addrs[0]),
     .col_addr_out  (col_addrs[0]),
     .char_data_out (char_data_outs[0]),
     .rgb_out       (rgb_outs[0])
     );
     genvar i;
     
     generate
     for (i = 1; i < NUM_CHARS; i = i + 1) begin
     charDisplay u_charDisplay(
     .rgb(rgbs[i]),
     .x_cnt         (x_cnt),
     .y_cnt         (y_cnt),
     .x_position    (x_positions[i]),
     .y_position    (y_positions[i]),
     .char_data     (char_datas[i]),
     .pre_char_data (char_data_outs[i-1]),
     .pre_rgb       (rgb_outs[i-1]),
     .pre_row_addr  (row_addrs[i]),
     .pre_col_addr  (col_addrs[i-1]),
     .char_valid    (char_valids[i]),
     .row_addr_out  (row_addrs[i]),
     .col_addr_out  (col_addrs[i]),
     .char_data_out (char_data_outs[i]),
     .rgb_out       (rgb_outs[i])
     );
     end
     
     endgenerate
     */
    /*
     wire [`CHAR_Y_BITS - 1:0] row_addr_1;
     wire [`CHAR_X_BITS - 1:0] col_addr_1;
     wire [`CHAR_BITS-1:0] char_data_1;
     wire [`RGB_BITS-1:0] rgb_1;
     wire char_valid_1;
     
     charDisplay
     #(
     .RGB (`WHITE)
     )
     charDisplay_CH1_C(
     .x_cnt         (x_cnt),
     .y_cnt         (y_cnt),
     .x_position    (100),
     .y_position    (1007),
     .char_data     (`CHAR_C),
     .pre_char_data (0),
     .pre_rgb       (0),
     .pre_row_addr  (0),
     .pre_col_addr  (0),
     .char_valid    (char_valid_1),
     .row_addr_out  (row_addr_1),
     .col_addr_out  (col_addr_1),
     .char_data_out (char_data_1),
     .rgb_out       (rgb_1)
     );
     
     wire [`CHAR_Y_BITS - 1:0] row_addr_2;
     wire [`CHAR_X_BITS - 1:0] col_addr_2;
     wire [`CHAR_BITS-1:0] char_data_2;
     wire [`RGB_BITS-1:0] rgb_2;
     wire char_valid_2;
     
     charDisplay
     #(
     .RGB (`WHITE)
     )
     charDisplay_CH1_H(
     .x_cnt         (x_cnt),
     .y_cnt         (y_cnt),
     .x_position    (113),
     .y_position    (1007),
     .char_data     (`CHAR_H),
     .pre_char_data (char_data_1),
     .pre_rgb       (rgb_1),
     .pre_row_addr  (row_addr_1),
     .pre_col_addr  (col_addr_1),
     .char_valid    (char_valid_2),
     .row_addr_out  (row_addr_2),
     .col_addr_out  (col_addr_2),
     .char_data_out (char_data_2),
     .rgb_out       (rgb_2)
     );
     
     wire [`CHAR_Y_BITS - 1:0] row_addr_3;
     wire [`CHAR_X_BITS - 1:0] col_addr_3;
     wire [`CHAR_BITS-1:0] char_data_3;
     wire [`RGB_BITS-1:0] rgb_3;
     wire char_valid_3;
     
     charDisplay
     #(
     .RGB (`WHITE)
     )
     charDisplay_CH1_1(
     .x_cnt         (x_cnt),
     .y_cnt         (y_cnt),
     .x_position    (126),
     .y_position    (1007),
     .char_data     (`CHAR_1),
     .pre_char_data (char_data_2),
     .pre_rgb       (rgb_2),
     .pre_row_addr  (row_addr_2),
     .pre_col_addr  (col_addr_2),
     .char_valid    (char_valid_3),
     .row_addr_out  (row_addr_3),
     .col_addr_out  (col_addr_3),
     .char_data_out (char_data_3),
     .rgb_out       (rgb_3)
     );
     
     wire [`CHAR_Y_BITS - 1:0] row_addr_4;
     wire [`CHAR_X_BITS - 1:0] col_addr_4;
     wire [`CHAR_BITS-1:0] char_data_4;
     wire [`RGB_BITS-1:0] rgb_4;
     wire char_valid_4;
     
     charDisplay
     #(
     .RGB (`WHITE)
     )
     charDisplay_CH1_MAX_1(
     .x_cnt         (x_cnt),
     .y_cnt         (y_cnt),
     .x_position    (139),
     .y_position    (1007),
     .char_data     ({3'h1, data_in_1_max_bcd[11:8]}),
     .pre_char_data (char_data_3),
     .pre_rgb       (rgb_3),
     .pre_row_addr  (row_addr_3),
     .pre_col_addr  (col_addr_3),
     .char_valid    (char_valid_4),
     .row_addr_out  (row_addr_4),
     .col_addr_out  (col_addr_4),
     .char_data_out (char_data_4),
     .rgb_out       (rgb_4)
     );
     
     wire [`CHAR_Y_BITS - 1:0] row_addr_5;
     wire [`CHAR_X_BITS - 1:0] col_addr_5;
     wire [`CHAR_BITS-1:0] char_data_5;
     wire [`RGB_BITS-1:0] rgb_5;
     wire char_valid_5;
     
     charDisplay
     #(
     .RGB (`WHITE)
     )
     charDisplay_CH1_MAX_2(
     .x_cnt         (x_cnt),
     .y_cnt         (y_cnt),
     .x_position    (152),
     .y_position    (1007),
     .char_data     ({3'h1, data_in_2_max_bcd[7:4]}),
     .pre_char_data (char_data_4),
     .pre_rgb       (rgb_4),
     .pre_row_addr  (row_addr_4),
     .pre_col_addr  (col_addr_4),
     .char_valid    (char_valid_5),
     .row_addr_out  (row_addr_5),
     .col_addr_out  (col_addr_5),
     .char_data_out (char_data_5),
     .rgb_out       (rgb_5)
     );
     
     wire [`CHAR_Y_BITS - 1:0] row_addr_6;
     wire [`CHAR_X_BITS - 1:0] col_addr_6;
     wire [`CHAR_BITS-1:0] char_data_6;
     wire [`RGB_BITS-1:0] rgb_6;
     wire char_valid_6;
     
     charDisplay
     #(
     .RGB (`WHITE)
     )
     charDisplay_CH1_MAX_3(
     .x_cnt         (x_cnt),
     .y_cnt         (y_cnt),
     .x_position    (165),
     .y_position    (1007),
     .char_data     ({3'h1, data_in_3_max_bcd[3:0]}),
     .pre_char_data (char_data_5),
     .pre_rgb       (rgb_5),
     .pre_row_addr  (row_addr_5),
     .pre_col_addr  (col_addr_5),
     .char_valid    (char_valid_6),
     .row_addr_out  (row_addr_6),
     .col_addr_out  (col_addr_6),
     .char_data_out (char_data_6),
     .rgb_out       (rgb_6)
     );
     
     wire [`CHAR_Y_BITS - 1:0] row_addr_7;
     wire [`CHAR_X_BITS - 1:0] col_addr_7;
     wire [`CHAR_BITS-1:0] char_data_7;
     wire [`RGB_BITS-1:0] rgb_7;
     wire char_valid_7;
     
     charDisplay
     #(
     .RGB (`WHITE)
     )
     charDisplay_CH1_MIN_1(
     .x_cnt         (x_cnt),
     .y_cnt         (y_cnt),
     .x_position    (178),
     .y_position    (1007),
     .char_data     ({3'h1, data_in_1_min_bcd[11:8]}),
     .pre_char_data (char_data_6),
     .pre_rgb       (rgb_6),
     .pre_row_addr  (row_addr_6),
     .pre_col_addr  (col_addr_6),
     .char_valid    (char_valid_7),
     .row_addr_out  (row_addr_7),
     .col_addr_out  (col_addr_7),
     .char_data_out (char_data_7),
     .rgb_out       (rgb_7)
     );
     
     wire [`CHAR_Y_BITS - 1:0] row_addr_8;
     wire [`CHAR_X_BITS - 1:0] col_addr_8;
     wire [`CHAR_BITS-1:0] char_data_8;
     wire [`RGB_BITS-1:0] rgb_8;
     wire char_valid_8;
     
     charDisplay
     #(
     .RGB (`WHITE)
     )
     charDisplay_CH1_MIN_2(
     .x_cnt         (x_cnt),
     .y_cnt         (y_cnt),
     .x_position    (191),
     .y_position    (1007),
     .char_data     ({3'h1, data_in_2_min_bcd[7:4]}),
     .pre_char_data (char_data_7),
     .pre_rgb       (rgb_7),
     .pre_row_addr  (row_addr_7),
     .pre_col_addr  (col_addr_7),
     .char_valid    (char_valid_8),
     .row_addr_out  (row_addr_8),
     .col_addr_out  (col_addr_8),
     .char_data_out (char_data_8),
     .rgb_out       (rgb_8)
     );
     
     wire [`CHAR_Y_BITS - 1:0] row_addr_9;
     wire [`CHAR_X_BITS - 1:0] col_addr_9;
     wire [`CHAR_BITS-1:0] char_data_9;
     wire [`RGB_BITS-1:0] rgb_9;
     wire char_valid_9;
     
     charDisplay
     #(
     .RGB (`WHITE)
     )
     charDisplay_CH1_MIN_3(
     .x_cnt         (x_cnt),
     .y_cnt         (y_cnt),
     .x_position    (204),
     .y_position    (1007),
     .char_data     ({3'h1, data_in_3_min_bcd[3:0]}),
     .pre_char_data (char_data_8),
     .pre_rgb       (rgb_8),
     .pre_row_addr  (row_addr_8),
     .pre_col_addr  (col_addr_8),
     .char_valid    (char_valid_9),
     .row_addr_out  (row_addr_9),
     .col_addr_out  (col_addr_9),
     .char_data_out (char_data_9),
     .rgb_out       (rgb_9)
     );
     
     wire [`CHAR_Y_BITS - 1:0] row_addr_10;
     wire [`CHAR_X_BITS - 1:0] col_addr_10;
     wire [`CHAR_BITS-1:0] char_data_10;
     wire [`RGB_BITS-1:0] rgb_10;
     wire char_valid_10;
     
     charDisplay
     #(
     .RGB (`WHITE)
     )
     charDisplay_CH2_C(
     .x_cnt         (x_cnt),
     .y_cnt         (y_cnt),
     .x_position    (217),
     .y_position    (1007),
     .char_data     (`CHAR_C),
     .pre_char_data (char_data_9),
     .pre_rgb       (rgb_9),
     .pre_row_addr  (row_addr_9),
     .pre_col_addr  (col_addr_9),
     .char_valid    (char_valid_10),
     .row_addr_out  (row_addr_10),
     .col_addr_out  (col_addr_10),
     .char_data_out (char_data_10),
     .rgb_out       (rgb_10)
     );
     
     wire [`CHAR_Y_BITS - 1:0] row_addr_11;
     wire [`CHAR_X_BITS - 1:0] col_addr_11;
     wire [`CHAR_BITS-1:0] char_data_11;
     wire [`RGB_BITS-1:0] rgb_11;
     wire char_valid_11;
     
     charDisplay
     #(
     .RGB (`WHITE)
     )
     charDisplay_CH2_H(
     .x_cnt         (x_cnt),
     .y_cnt         (y_cnt),
     .x_position    (230),
     .y_position    (1007),
     .char_data     (`CHAR_H),
     .pre_char_data (char_data_10),
     .pre_rgb       (rgb_10),
     .pre_row_addr  (row_addr_10),
     .pre_col_addr  (col_addr_10),
     .char_valid    (char_valid_11),
     .row_addr_out  (row_addr_11),
     .col_addr_out  (col_addr_11),
     .char_data_out (char_data_11),
     .rgb_out       (rgb_11)
     );
     
     wire [`CHAR_Y_BITS - 1:0] row_addr_12;
     wire [`CHAR_X_BITS - 1:0] col_addr_12;
     wire [`CHAR_BITS-1:0] char_data_12;
     wire [`RGB_BITS-1:0] rgb_12;
     wire char_valid_12;
     
     charDisplay
     #(
     .RGB (`WHITE)
     )
     charDisplay_CH2_2(
     .x_cnt         (x_cnt),
     .y_cnt         (y_cnt),
     .x_position    (243),
     .y_position    (1007),
     .char_data     (`CHAR_2),
     .pre_char_data (char_data_11),
     .pre_rgb       (rgb_11),
     .pre_row_addr  (row_addr_11),
     .pre_col_addr  (col_addr_11),
     .char_valid    (char_valid_12),
     .row_addr_out  (row_addr_12),
     .col_addr_out  (col_addr_12),
     .char_data_out (char_data_12),
     .rgb_out       (rgb_12)
     );
     
     wire [`CHAR_Y_BITS - 1:0] row_addr_13;
     wire [`CHAR_X_BITS - 1:0] col_addr_13;
     wire [`CHAR_BITS-1:0] char_data_13;
     wire [`RGB_BITS-1:0] rgb_13;
     wire char_valid_13;
     
     charDisplay
     #(
     .RGB (`WHITE)
     )
     charDisplay_CH2_MAX_1(
     .x_cnt         (x_cnt),
     .y_cnt         (y_cnt),
     .x_position    (256),
     .y_position    (1007),
     .char_data     ({3'h1, data_in_3_max_bcd[11:8]}),
     .pre_char_data (char_data_12),
     .pre_rgb       (rgb_12),
     .pre_row_addr  (row_addr_12),
     .pre_col_addr  (col_addr_12),
     .char_valid    (char_valid_13),
     .row_addr_out  (row_addr_13),
     .col_addr_out  (col_addr_13),
     .char_data_out (char_data_13),
     .rgb_out       (rgb_13)
     );
     
     wire [`CHAR_Y_BITS - 1:0] row_addr_14;
     wire [`CHAR_X_BITS - 1:0] col_addr_14;
     wire [`CHAR_BITS-1:0] char_data_14;
     wire [`RGB_BITS-1:0] rgb_14;
     wire char_valid_14;
     
     charDisplay
     #(
     .RGB (`WHITE)
     )
     charDisplay_CH2_MAX_2(
     
     */
    
    
    wire dout;
    
    charRead u_charRead(
    .clka       (clk),
    .x_cnt      (x_cnt),
    .y_cnt      (y_cnt),
    .char_data  (char_data),
    .row_addr   (row_addr),
    .col_addr   (col_addr),
    .douta      (dout)
    );
    
    assign info_valid = rgb_out == (12'b0) ? 1'b0 : 1'b1;
    assign rgb_out    = dout ? rgb : pre_rgb;
    
    /*    charRead u_charRead(
     .clka       (clk),
     .x_cnt      (x_cnt),
     .y_cnt      (y_cnt),
     .char_data  (char_data_outs[NUM_CHARS - 1]),
     .row_addr   (row_addrs[NUM_CHARS - 1]),
     .col_addr   (col_addrs[NUM_CHARS - 1]),
     .douta      (dout)
     );
     
     assign info_valid = rgb_outs[NUM_CHARS - 1] == (12'b0) ? 1'b0 : 1'b1;
     assign rgb_out    = (info_valid & dout) ? rgb_outs[NUM_CHARS - 1] : pre_rgb;
     */
    
endmodule
