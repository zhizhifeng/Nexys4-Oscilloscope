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
    	.bin_in ({6'b0, h_scale + 1} ),
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

    reg [`RGB_BITS - 1:0] rgb;
    reg [`CHAR_Y_BITS - 1:0] row_addr;
    reg [`CHAR_X_BITS - 1:0] col_addr;
    reg [`CHAR_BITS-1:0] char_data;
    reg char_valid;
    
    always @ (*) begin
        if (x_positions[0] <= x_cnt && x_cnt < (x_positions[0] + `CHAR_X_LEN) &&
            y_positions[0] <= y_cnt && y_cnt < (y_positions[0] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[0];
            row_addr   <= y_cnt - y_positions[0];
            char_data  <= char_datas[0];
            rgb        <= rgbs[0];
        end else if (x_positions[1] <= x_cnt && x_cnt < (x_positions[1] + `CHAR_X_LEN) &&
            y_positions[1] <= y_cnt && y_cnt < (y_positions[1] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[1];
            row_addr   <= y_cnt - y_positions[1];
            char_data  <= char_datas[1];
            rgb        <= rgbs[1];
        end else if (x_positions[2] <= x_cnt && x_cnt < (x_positions[2] + `CHAR_X_LEN) &&
            y_positions[2] <= y_cnt && y_cnt < (y_positions[2] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[2];
            row_addr   <= y_cnt - y_positions[2];
            char_data  <= char_datas[2];
            rgb        <= rgbs[2];
        end else if (x_positions[3] <= x_cnt && x_cnt < (x_positions[3] + `CHAR_X_LEN) &&
            y_positions[3] <= y_cnt && y_cnt < (y_positions[3] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[3];
            row_addr   <= y_cnt - y_positions[3];
            char_data  <= char_datas[3];
            rgb        <= rgbs[3];
        end else if (x_positions[4] <= x_cnt && x_cnt < (x_positions[4] + `CHAR_X_LEN) &&
            y_positions[4] <= y_cnt && y_cnt < (y_positions[4] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[4];
            row_addr   <= y_cnt - y_positions[4];
            char_data  <= char_datas[4];
            rgb        <= rgbs[4];
        end else if (x_positions[5] <= x_cnt && x_cnt < (x_positions[5] + `CHAR_X_LEN) &&
            y_positions[5] <= y_cnt && y_cnt < (y_positions[5] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[5];
            row_addr   <= y_cnt - y_positions[5];
            char_data  <= char_datas[5];
            rgb        <= rgbs[5];
        end else if (x_positions[6] <= x_cnt && x_cnt < (x_positions[6] + `CHAR_X_LEN) &&
            y_positions[6] <= y_cnt && y_cnt < (y_positions[6] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[6];
            row_addr   <= y_cnt - y_positions[6];
            char_data  <= char_datas[6];
            rgb        <= rgbs[6];
        end else if (x_positions[7] <= x_cnt && x_cnt < (x_positions[7] + `CHAR_X_LEN) &&
            y_positions[7] <= y_cnt && y_cnt < (y_positions[7] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[7];
            row_addr   <= y_cnt - y_positions[7];
            char_data  <= char_datas[7];
            rgb        <= rgbs[7];
        end else if (x_positions[8] <= x_cnt && x_cnt < (x_positions[8] + `CHAR_X_LEN) &&
            y_positions[8] <= y_cnt && y_cnt < (y_positions[8] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[8];
            row_addr   <= y_cnt - y_positions[8];
            char_data  <= char_datas[8];
            rgb        <= rgbs[8];
        end else if (x_positions[9] <= x_cnt && x_cnt < (x_positions[9] + `CHAR_X_LEN) &&
            y_positions[9] <= y_cnt && y_cnt < (y_positions[9] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[9];
            row_addr   <= y_cnt - y_positions[9];
            char_data  <= char_datas[9];
            rgb        <= rgbs[9];
        end else if (x_positions[10] <= x_cnt && x_cnt < (x_positions[10] + `CHAR_X_LEN) &&
            y_positions[10] <= y_cnt && y_cnt < (y_positions[10] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[10];
            row_addr   <= y_cnt - y_positions[10];
            char_data  <= char_datas[10];
            rgb        <= rgbs[10];
        end else if (x_positions[11] <= x_cnt && x_cnt < (x_positions[11] + `CHAR_X_LEN) &&
            y_positions[11] <= y_cnt && y_cnt < (y_positions[11] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[11];
            row_addr   <= y_cnt - y_positions[11];
            char_data  <= char_datas[11];
            rgb        <= rgbs[11];
        end else if (x_positions[12] <= x_cnt && x_cnt < (x_positions[12] + `CHAR_X_LEN) &&
            y_positions[12] <= y_cnt && y_cnt < (y_positions[12] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[12];
            row_addr   <= y_cnt - y_positions[12];
            char_data  <= char_datas[12];
            rgb        <= rgbs[12];
        end else if (x_positions[13] <= x_cnt && x_cnt < (x_positions[13] + `CHAR_X_LEN) &&
            y_positions[13] <= y_cnt && y_cnt < (y_positions[13] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[13];
            row_addr   <= y_cnt - y_positions[13];
            char_data  <= char_datas[13];
            rgb        <= rgbs[13];
        end else if (x_positions[14] <= x_cnt && x_cnt < (x_positions[14] + `CHAR_X_LEN) &&
            y_positions[14] <= y_cnt && y_cnt < (y_positions[14] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[14];
            row_addr   <= y_cnt - y_positions[14];
            char_data  <= char_datas[14];
            rgb        <= rgbs[14];
        end else if (x_positions[15] <= x_cnt && x_cnt < (x_positions[15] + `CHAR_X_LEN) &&
            y_positions[15] <= y_cnt && y_cnt < (y_positions[15] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[15];
            row_addr   <= y_cnt - y_positions[15];
            char_data  <= char_datas[15];
            rgb        <= rgbs[15];
        end else if (x_positions[16] <= x_cnt && x_cnt < (x_positions[16] + `CHAR_X_LEN) &&
            y_positions[16] <= y_cnt && y_cnt < (y_positions[16] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[16];
            row_addr   <= y_cnt - y_positions[16];
            char_data  <= char_datas[16];
            rgb        <= rgbs[16];
        end else if (x_positions[17] <= x_cnt && x_cnt < (x_positions[17] + `CHAR_X_LEN) &&
            y_positions[17] <= y_cnt && y_cnt < (y_positions[17] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[17];
            row_addr   <= y_cnt - y_positions[17];
            char_data  <= char_datas[17];
            rgb        <= rgbs[17];
        end else if (x_positions[18] <= x_cnt && x_cnt < (x_positions[18] + `CHAR_X_LEN) &&
            y_positions[18] <= y_cnt && y_cnt < (y_positions[18] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[18];
            row_addr   <= y_cnt - y_positions[18];
            char_data  <= char_datas[18];
            rgb        <= rgbs[18];
        end else if (x_positions[19] <= x_cnt && x_cnt < (x_positions[19] + `CHAR_X_LEN) &&
            y_positions[19] <= y_cnt && y_cnt < (y_positions[19] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[19];
            row_addr   <= y_cnt - y_positions[19];
            char_data  <= char_datas[19];
            rgb        <= rgbs[19];
        end else if (x_positions[20] <= x_cnt && x_cnt < (x_positions[20] + `CHAR_X_LEN) &&
            y_positions[20] <= y_cnt && y_cnt < (y_positions[20] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[20];
            row_addr   <= y_cnt - y_positions[20];
            char_data  <= char_datas[20];
            rgb        <= rgbs[20];
        end else if (x_positions[21] <= x_cnt && x_cnt < (x_positions[21] + `CHAR_X_LEN) &&
            y_positions[21] <= y_cnt && y_cnt < (y_positions[21] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[21];
            row_addr   <= y_cnt - y_positions[21];
            char_data  <= char_datas[21];
            rgb        <= rgbs[21];
        end else if (x_positions[22] <= x_cnt && x_cnt < (x_positions[22] + `CHAR_X_LEN) &&
            y_positions[22] <= y_cnt && y_cnt < (y_positions[22] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[22];
            row_addr   <= y_cnt - y_positions[22];
            char_data  <= char_datas[22];
            rgb        <= rgbs[22];
        end else if (x_positions[23] <= x_cnt && x_cnt < (x_positions[23] + `CHAR_X_LEN) &&
            y_positions[23] <= y_cnt && y_cnt < (y_positions[23] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[23];
            row_addr   <= y_cnt - y_positions[23];
            char_data  <= char_datas[23];
            rgb        <= rgbs[23];
        end else if (x_positions[24] <= x_cnt && x_cnt < (x_positions[24] + `CHAR_X_LEN) &&
            y_positions[24] <= y_cnt && y_cnt < (y_positions[24] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[24];
            row_addr   <= y_cnt - y_positions[24];
            char_data  <= char_datas[24];
            rgb        <= rgbs[24];
        end else if (x_positions[25] <= x_cnt && x_cnt < (x_positions[25] + `CHAR_X_LEN) &&
            y_positions[25] <= y_cnt && y_cnt < (y_positions[25] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[25];
            row_addr   <= y_cnt - y_positions[25];
            char_data  <= char_datas[25];
            rgb        <= rgbs[25];
        end else if (x_positions[26] <= x_cnt && x_cnt < (x_positions[26] + `CHAR_X_LEN) &&
            y_positions[26] <= y_cnt && y_cnt < (y_positions[26] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[26];
            row_addr   <= y_cnt - y_positions[26];
            char_data  <= char_datas[26];
            rgb        <= rgbs[26];
        end else if (x_positions[27] <= x_cnt && x_cnt < (x_positions[27] + `CHAR_X_LEN) &&
            y_positions[27] <= y_cnt && y_cnt < (y_positions[27] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[27];
            row_addr   <= y_cnt - y_positions[27];
            char_data  <= char_datas[27];
            rgb        <= rgbs[27];
        end else if (x_positions[28] <= x_cnt && x_cnt < (x_positions[28] + `CHAR_X_LEN) &&
            y_positions[28] <= y_cnt && y_cnt < (y_positions[28] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[28];
            row_addr   <= y_cnt - y_positions[28];
            char_data  <= char_datas[28];
            rgb        <= rgbs[28];
        end else if (x_positions[29] <= x_cnt && x_cnt < (x_positions[29] + `CHAR_X_LEN) &&
            y_positions[29] <= y_cnt && y_cnt < (y_positions[29] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[29];
            row_addr   <= y_cnt - y_positions[29];
            char_data  <= char_datas[29];
            rgb        <= rgbs[29];
        end else if (x_positions[30] <= x_cnt && x_cnt < (x_positions[30] + `CHAR_X_LEN) &&
            y_positions[30] <= y_cnt && y_cnt < (y_positions[30] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[30];
            row_addr   <= y_cnt - y_positions[30];
            char_data  <= char_datas[30];
            rgb        <= rgbs[30];
        end else if (x_positions[31] <= x_cnt && x_cnt < (x_positions[31] + `CHAR_X_LEN) &&
            y_positions[31] <= y_cnt && y_cnt < (y_positions[31] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[31];
            row_addr   <= y_cnt - y_positions[31];
            char_data  <= char_datas[31];
            rgb        <= rgbs[31];
        end else if (x_positions[32] <= x_cnt && x_cnt < (x_positions[32] + `CHAR_X_LEN) &&
            y_positions[32] <= y_cnt && y_cnt < (y_positions[32] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[32];
            row_addr   <= y_cnt - y_positions[32];
            char_data  <= char_datas[32];
            rgb        <= rgbs[32];
        end else if (x_positions[33] <= x_cnt && x_cnt < (x_positions[33] + `CHAR_X_LEN) &&
            y_positions[33] <= y_cnt && y_cnt < (y_positions[33] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[33];
            row_addr   <= y_cnt - y_positions[33];
            char_data  <= char_datas[33];
            rgb        <= rgbs[33];
        end else if (x_positions[34] <= x_cnt && x_cnt < (x_positions[34] + `CHAR_X_LEN) &&
            y_positions[34] <= y_cnt && y_cnt < (y_positions[34] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[34];
            row_addr   <= y_cnt - y_positions[34];
            char_data  <= char_datas[34];
            rgb        <= rgbs[34];
        end else if (x_positions[35] <= x_cnt && x_cnt < (x_positions[35] + `CHAR_X_LEN) &&
            y_positions[35] <= y_cnt && y_cnt < (y_positions[35] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[35];
            row_addr   <= y_cnt - y_positions[35];
            char_data  <= char_datas[35];
            rgb        <= rgbs[35];
        end else if (x_positions[36] <= x_cnt && x_cnt < (x_positions[36] + `CHAR_X_LEN) &&
            y_positions[36] <= y_cnt && y_cnt < (y_positions[36] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[36];
            row_addr   <= y_cnt - y_positions[36];
            char_data  <= char_datas[36];
            rgb        <= rgbs[36];
        end else if (x_positions[37] <= x_cnt && x_cnt < (x_positions[37] + `CHAR_X_LEN) &&
            y_positions[37] <= y_cnt && y_cnt < (y_positions[37] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[37];
            row_addr   <= y_cnt - y_positions[37];
            char_data  <= char_datas[37];
            rgb        <= rgbs[37];
        end else if (x_positions[38] <= x_cnt && x_cnt < (x_positions[38] + `CHAR_X_LEN) &&
            y_positions[38] <= y_cnt && y_cnt < (y_positions[38] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[38];
            row_addr   <= y_cnt - y_positions[38];
            char_data  <= char_datas[38];
            rgb        <= rgbs[38];
        end else if (x_positions[39] <= x_cnt && x_cnt < (x_positions[39] + `CHAR_X_LEN) &&
            y_positions[39] <= y_cnt && y_cnt < (y_positions[39] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[39];
            row_addr   <= y_cnt - y_positions[39];
            char_data  <= char_datas[39];
            rgb        <= rgbs[39];
        end else if (x_positions[40] <= x_cnt && x_cnt < (x_positions[40] + `CHAR_X_LEN) &&
            y_positions[40] <= y_cnt && y_cnt < (y_positions[40] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[40];
            row_addr   <= y_cnt - y_positions[40];
            char_data  <= char_datas[40];
            rgb        <= rgbs[40];
        end else if (x_positions[41] <= x_cnt && x_cnt < (x_positions[41] + `CHAR_X_LEN) &&
            y_positions[41] <= y_cnt && y_cnt < (y_positions[41] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[41];
            row_addr   <= y_cnt - y_positions[41];
            char_data  <= char_datas[41];
            rgb        <= rgbs[41];
        end else if (x_positions[42] <= x_cnt && x_cnt < (x_positions[42] + `CHAR_X_LEN) &&
            y_positions[42] <= y_cnt && y_cnt < (y_positions[42] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[42];
            row_addr   <= y_cnt - y_positions[42];
            char_data  <= char_datas[42];
            rgb        <= rgbs[42];
        end else if (x_positions[43] <= x_cnt && x_cnt < (x_positions[43] + `CHAR_X_LEN) &&
            y_positions[43] <= y_cnt && y_cnt < (y_positions[43] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[43];
            row_addr   <= y_cnt - y_positions[43];
            char_data  <= char_datas[43];
            rgb        <= rgbs[43];
        end else if (x_positions[44] <= x_cnt && x_cnt < (x_positions[44] + `CHAR_X_LEN) &&
            y_positions[44] <= y_cnt && y_cnt < (y_positions[44] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[44];
            row_addr   <= y_cnt - y_positions[44];
            char_data  <= char_datas[44];
            rgb        <= rgbs[44];
        end else if (x_positions[45] <= x_cnt && x_cnt < (x_positions[45] + `CHAR_X_LEN) &&
            y_positions[45] <= y_cnt && y_cnt < (y_positions[45] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[45];
            row_addr   <= y_cnt - y_positions[45];
            char_data  <= char_datas[45];
            rgb        <= rgbs[45];
        end else if (x_positions[46] <= x_cnt && x_cnt < (x_positions[46] + `CHAR_X_LEN) &&
            y_positions[46] <= y_cnt && y_cnt < (y_positions[46] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[46];
            row_addr   <= y_cnt - y_positions[46];
            char_data  <= char_datas[46];
            rgb        <= rgbs[46];
        end else if (x_positions[47] <= x_cnt && x_cnt < (x_positions[47] + `CHAR_X_LEN) &&
            y_positions[47] <= y_cnt && y_cnt < (y_positions[47] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[47];
            row_addr   <= y_cnt - y_positions[47];
            char_data  <= char_datas[47];
            rgb        <= rgbs[47];
        end else if (x_positions[48] <= x_cnt && x_cnt < (x_positions[48] + `CHAR_X_LEN) &&
            y_positions[48] <= y_cnt && y_cnt < (y_positions[48] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[48];
            row_addr   <= y_cnt - y_positions[48];
            char_data  <= char_datas[48];
            rgb        <= rgbs[48];
        end else if (x_positions[49] <= x_cnt && x_cnt < (x_positions[49] + `CHAR_X_LEN) &&
            y_positions[49] <= y_cnt && y_cnt < (y_positions[49] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[49];
            row_addr   <= y_cnt - y_positions[49];
            char_data  <= char_datas[49];
            rgb        <= rgbs[49];
        end else if (x_positions[50] <= x_cnt && x_cnt < (x_positions[50] + `CHAR_X_LEN) &&
            y_positions[50] <= y_cnt && y_cnt < (y_positions[50] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[50];
            row_addr   <= y_cnt - y_positions[50];
            char_data  <= char_datas[50];
            rgb        <= rgbs[50];
        end else if (x_positions[51] <= x_cnt && x_cnt < (x_positions[51] + `CHAR_X_LEN) &&
            y_positions[51] <= y_cnt && y_cnt < (y_positions[51] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[51];
            row_addr   <= y_cnt - y_positions[51];
            char_data  <= char_datas[51];
            rgb        <= rgbs[51];
        end else if (x_positions[52] <= x_cnt && x_cnt < (x_positions[52] + `CHAR_X_LEN) &&
            y_positions[52] <= y_cnt && y_cnt < (y_positions[52] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[52];
            row_addr   <= y_cnt - y_positions[52];
            char_data  <= char_datas[52];
            rgb        <= rgbs[52];
        end else if (x_positions[53] <= x_cnt && x_cnt < (x_positions[53] + `CHAR_X_LEN) &&
            y_positions[53] <= y_cnt && y_cnt < (y_positions[53] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[53];
            row_addr   <= y_cnt - y_positions[53];
            char_data  <= char_datas[53];
            rgb        <= rgbs[53];
        end else if (x_positions[54] <= x_cnt && x_cnt < (x_positions[54] + `CHAR_X_LEN) &&
            y_positions[54] <= y_cnt && y_cnt < (y_positions[54] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[54];
            row_addr   <= y_cnt - y_positions[54];
            char_data  <= char_datas[54];
            rgb        <= rgbs[54];
        end else if (x_positions[55] <= x_cnt && x_cnt < (x_positions[55] + `CHAR_X_LEN) &&
            y_positions[55] <= y_cnt && y_cnt < (y_positions[55] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[55];
            row_addr   <= y_cnt - y_positions[55];
            char_data  <= char_datas[55];
            rgb        <= rgbs[55];
        end else if (x_positions[56] <= x_cnt && x_cnt < (x_positions[56] + `CHAR_X_LEN) &&
            y_positions[56] <= y_cnt && y_cnt < (y_positions[56] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[56];
            row_addr   <= y_cnt - y_positions[56];
            char_data  <= char_datas[56];
            rgb        <= rgbs[56];
        end else if (x_positions[57] <= x_cnt && x_cnt < (x_positions[57] + `CHAR_X_LEN) &&
            y_positions[57] <= y_cnt && y_cnt < (y_positions[57] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[57];
            row_addr   <= y_cnt - y_positions[57];
            char_data  <= char_datas[57];
            rgb        <= rgbs[57];
        end else if (x_positions[58] <= x_cnt && x_cnt < (x_positions[58] + `CHAR_X_LEN) &&
            y_positions[58] <= y_cnt && y_cnt < (y_positions[58] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[58];
            row_addr   <= y_cnt - y_positions[58];
            char_data  <= char_datas[58];
            rgb        <= rgbs[58];
        end else if (x_positions[59] <= x_cnt && x_cnt < (x_positions[59] + `CHAR_X_LEN) &&
            y_positions[59] <= y_cnt && y_cnt < (y_positions[59] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[59];
            row_addr   <= y_cnt - y_positions[59];
            char_data  <= char_datas[59];
            rgb        <= rgbs[59];
        end else if (x_positions[60] <= x_cnt && x_cnt < (x_positions[60] + `CHAR_X_LEN) &&
            y_positions[60] <= y_cnt && y_cnt < (y_positions[60] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[60];
            row_addr   <= y_cnt - y_positions[60];
            char_data  <= char_datas[60];
            rgb        <= rgbs[60];
        end else if (x_positions[61] <= x_cnt && x_cnt < (x_positions[61] + `CHAR_X_LEN) &&
            y_positions[61] <= y_cnt && y_cnt < (y_positions[61] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[61];
            row_addr   <= y_cnt - y_positions[61];
            char_data  <= char_datas[61];
            rgb        <= rgbs[61];
        end else if (x_positions[62] <= x_cnt && x_cnt < (x_positions[62] + `CHAR_X_LEN) &&
            y_positions[62] <= y_cnt && y_cnt < (y_positions[62] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[62];
            row_addr   <= y_cnt - y_positions[62];
            char_data  <= char_datas[62];
            rgb        <= rgbs[62];
        end else if (x_positions[63] <= x_cnt && x_cnt < (x_positions[63] + `CHAR_X_LEN) &&
            y_positions[63] <= y_cnt && y_cnt < (y_positions[63] + `CHAR_Y_LEN)) begin
            char_valid <= 1;
            col_addr   <= x_cnt - x_positions[63];
            row_addr   <= y_cnt - y_positions[63];
            char_data  <= char_datas[63];
            rgb        <= rgbs[63];
        end else begin
            char_valid <= 0;
            col_addr   <= 0;
            row_addr   <= 0;
            char_data  <= 0;
            rgb        <= 0;
        end
    end

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
    
    assign info_valid = char_valid ? 1'b1 : 1'b0;
    assign rgb_out    = dout ? rgb : pre_rgb;

endmodule

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

    charRead u_charRead(
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
