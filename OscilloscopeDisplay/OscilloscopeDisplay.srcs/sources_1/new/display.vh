
`define HORIZONTAL_ZERO 500 //TODO: implement adjustable zero point

`define DATA_IN_BITS 12
`define DATA_ADDRESS_BITS 12
`define SCALE_BITS 4

//parameters for display
`define DISPLAY_X_LEN 1280
`define DISPLAY_Y_LEN 1024
`define DISPLAY_X_BITS 11
`define DISPLAY_Y_BITS 10
`define RGB_BITS 12
`define EX_CONST 1'b0
`define ABS(x) ((x) > 0 ? (x) : (0 - (x)))


//RGB
`define RED 12'hFFF
`define GREEN 12'h0F0
`define BLUE 12'h00F
`define YELLOW 12'hFF0
`define CYAN 12'h0FF
`define MAGENTA 12'hF0F
`define WHITE 12'hFFF
`define GRAY 12'h888
`define BLACK 12'h000

//parameters for char display
`define CHAR_X_LEN 13
`define CHAR_Y_LEN 12
`define CHAR_X_BITS 4
`define CHAR_Y_BITS 5
`define CHAR_BITS 7

//SP ! " # $ % & ' ( ) * + , - . /
`define CHAR_SP 7'h00
`define CHAR_EXCLAMATION 7'h01
`define CHAR_QUOTATION 7'h02
`define CHAR_HASH 7'h03
`define CHAR_DOLLAR 7'h04
`define CHAR_PERCENT 7'h05
`define CHAR_AMPERSAND 7'h06
`define CHAR_APOSTROPHE 7'h07
`define CHAR_LEFT_PARENTHESIS 7'h08
`define CHAR_RIGHT_PARENTHESIS 7'h09
`define CHAR_ASTERISK 7'h0A
`define CHAR_PLUS 7'h0B
`define CHAR_COMMA 7'h0C
`define CHAR_MINUS 7'h0D
`define CHAR_PERIOD 7'h0E
`define CHAR_SLASH 7'h0F

//0 1 2 3 4 5 6 7 8 9 : ; < = > ?
`define CHAR_0 7'h10
`define CHAR_1 7'h11
`define CHAR_2 7'h12
`define CHAR_3 7'h13
`define CHAR_4 7'h14
`define CHAR_5 7'h15
`define CHAR_6 7'h16
`define CHAR_7 7'h17
`define CHAR_8 7'h18
`define CHAR_9 7'h19
`define CHAR_COLON 7'h1A
`define CHAR_SEMICOLON 7'h1B
`define CHAR_LESS_THAN 7'h1C
`define CHAR_EQUALS 7'h1D
`define CHAR_GREATER_THAN 7'h1E
`define CHAR_QUESTION 7'h1F

//@ A B C D E F G H I J K L M N O
`define CHAR_AT 7'h20
`define CHAR_A 7'h21
`define CHAR_B 7'h22
`define CHAR_C 7'h23
`define CHAR_D 7'h24
`define CHAR_E 7'h25
`define CHAR_F 7'h26
`define CHAR_G 7'h27
`define CHAR_H 7'h28
`define CHAR_I 7'h29
`define CHAR_J 7'h2A
`define CHAR_K 7'h2B
`define CHAR_L 7'h2C
`define CHAR_M 7'h2D
`define CHAR_N 7'h2E
`define CHAR_O 7'h2F

//P Q R S T U V W X Y Z [ \ ] ^ _
`define CHAR_P 7'h30
`define CHAR_Q 7'h31
`define CHAR_R 7'h32
`define CHAR_S 7'h33
`define CHAR_T 7'h34
`define CHAR_U 7'h35
`define CHAR_V 7'h36
`define CHAR_W 7'h37
`define CHAR_X 7'h38
`define CHAR_Y 7'h39
`define CHAR_Z 7'h3A
`define CHAR_LEFT_BRACKET 7'h3B
`define CHAR_BACKSLASH 7'h3C
`define CHAR_RIGHT_BRACKET 7'h3D
`define CHAR_CARET 7'h3E
`define CHAR_UNDERSCORE 7'h3F

//` a b c d e f g h i j k l m n o
`define CHAR_GRAVE_ACCENT 7'h40
`define CHAR_a 7'h41
`define CHAR_b 7'h42
`define CHAR_c 7'h43
`define CHAR_d 7'h44
`define CHAR_e 7'h45
`define CHAR_f 7'h46
`define CHAR_g 7'h47
`define CHAR_h 7'h48
`define CHAR_i 7'h49
`define CHAR_j 7'h4A
`define CHAR_k 7'h4B
`define CHAR_l 7'h4C
`define CHAR_m 7'h4D
`define CHAR_n 7'h4E
`define CHAR_o 7'h4F

//p q r s t u v w x y z { | } ~
`define CHAR_p 7'h50
`define CHAR_q 7'h51
`define CHAR_r 7'h52
`define CHAR_s 7'h53
`define CHAR_t 7'h54
`define CHAR_u 7'h55
`define CHAR_v 7'h56
`define CHAR_w 7'h57
`define CHAR_x 7'h58
`define CHAR_y 7'h59
`define CHAR_z 7'h5A
`define CHAR_LEFT_BRACE 7'h5B
`define CHAR_VERTICAL_BAR 7'h5C
`define CHAR_RIGHT_BRACE 7'h5D
`define CHAR_TILDE 7'h5E