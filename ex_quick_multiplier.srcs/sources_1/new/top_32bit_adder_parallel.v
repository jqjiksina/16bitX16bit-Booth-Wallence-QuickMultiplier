`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/13 11:29:39
// Design Name: 
// Module Name: top_32bit_adder_parallel
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


module top_32bit_adder_parallel(
    input[31:0] A,
    input[31:0] B,
    input cin,
    output[31:0] S,
    output cout
    );
    
wire[8:0] C;
wire[7:0] P,G;
wire Ps,Gs;
assign C[0] = cin;
assign cout = C[8];

genvar i;
generate 
    for(i=0;i<8;i=i+1) begin:adder_4bit
        u74181 u_adder_4bit(
            .A(A[3+4*i:4*i]),
            .B(B[3+4*i:4*i]),
            .cin(C[i]),
            .S(S[3+4*i:4*i]),
            .Ps(P[i]),
            .Gs(G[i]),
            .cout()
);
    end
endgenerate

u74182 u1_adder_16bit(
        .P(P[3:0]),
        .G(G[3:0]),
        .cin(C[0]),
        .C(C[4:1]),
        .Ps(),
        .Gs()
    );
    
u74182 u2_adder_16bit(
        .P(P[7:4]),
        .G(G[7:4]),
        .cin(C[4]),
        .C(C[8:5]),
        .Ps(),
        .Gs()
    );


endmodule
