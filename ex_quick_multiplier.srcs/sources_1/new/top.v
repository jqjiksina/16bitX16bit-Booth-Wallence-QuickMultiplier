`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/01 16:56:32
// Design Name: 
// Module Name: top
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
`define get(num,i) (i > 17 ? num[17] : num[i])

//无符号16x16乘法
module top(
    input [15:0] x,
    input [15:0] y,
    output [31:0] z 
    );
    
wire [17:0] prod[8:0];

wire [18:0] y_ext = {2'b00,y,1'b0};

//booth_encode
genvar i;
generate
    for (i = 0; i <= 8; i = i + 1) begin:BOOTH
        gen_prod booth_encode(
            .x(x),
            .s(y_ext[i*2+2:i*2]),
            .prod(prod[i])
            );
    end
endgenerate

//wallence_tree
//wallence_tree tree(.prod(prod),.res(z));
//level 1
wire [15:0] s1_1;
wire [14:0] c1_1;
csa_3to2 #(
    .N(16)) csa_level1_1(
    .a(prod[8][15:0]),.b(prod[7][17:2]),.c({{2{prod[6][17]}},prod[6][17:4]}),.S(s1_1),.C(c1_1));

wire [21:0] s1_2;
wire [20:0] c1_2;
csa_3to2 #(
    .N(22)) csa_level1_2(
    .a({{4{prod[5][17]}},prod[5][17:0]}),
    .b({{6{prod[4][17]}},prod[4][17:2]}),
    .c({{8{prod[3][17]}},prod[3][17:4]}),
    .S(s1_2),.C(c1_2));

wire [27:0] s1_3;
wire [26:0] c1_3;
csa_3to2 #(
    .N(28)) csa_level1_3(
    .a({{10{prod[2][17]}},prod[2][17:0]}),
    .b({{12{prod[1][17]}},prod[1][17:2]}),
    .c({{14{prod[0][17]}},prod[0][17:4]}),
    .S(s1_3),.C(c1_3));

//level 2
wire [17:0] s2_1;
wire [16:0] c2_1;
csa_3to2 #(
    .N(18)) csa_level2_1(
    .a({c1_1[14:0],s1_1[0],prod[7][1:0]}),
    .b({s1_1[15:1],prod[6][4:2]}),
    .c(c1_2[20:3]),
    .S(s2_1),.C(c2_1));
    
wire [25:0] s2_2;
wire [24:0] c2_2;
csa_3to2 #(
    .N(26)) csa_level2_2(
    .a({s1_2[21:1],prod[3][4:0]}),
    .b(c1_3[26:1]),
    .c(s1_3[27:2]),
    .S(s2_2),.C(c2_2));

//level 3
wire [19:0] s3;
wire [18:0] c3;
csa_3to2 #(
    .N(20)) csa_level3(
    .a({c2_1[16:0],s2_1[0],prod[6][1:0]}),
    .b({s2_1[17:1],c1_2[3:1]}),
    .c(c2_2[24:5]),
    .S(s3),.C(c3));
    
//level 4
wire [23:0] s4;
wire [22:0] c4;
csa_3to2 #(
    .N(24)) csa_level4(
    .a({c3[18:0],s3[0],c1_2[0],s1_2[0],prod[4][1:0]}),
    .b({s3[19:1],c2_2[5:1]}),
    .c(s2_2[25:2]),
    .S(s4),.C(c4));
    
//32bit 先行进位
top_32bit_adder_parallel rca(
    .A({c4[22:0],s4[0],c2_2[0],s2_2[0],c1_3[0],s1_3[0],prod[1][1:0],2'b00}),
    .B({s4[23:1],s2_2[2:1],s1_3[2:1],prod[0][4:0]}),
    .cin(1'b0),
    .S(z),
    .cout());
    
endmodule
