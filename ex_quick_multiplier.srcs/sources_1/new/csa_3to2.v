`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/05 20:25:27
// Design Name: 
// Module Name: csa_3to2
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

//c[0]实际不会用到
module csa_3to2 #(
    parameter N = 16
    )(
    input [N-1:0]a,
    input [N-1:0]b,
    input [N-1:0]c,   
    output [N-1:0] S,
    output [N-1:0] C
    );
    
ha ha_temp(.a(a[0]),.b(b[0]),.s(S[0]),.cout(C[0]));
genvar i;
generate
    for(i = 1; i < N; i = i + 1) begin:csa
        fa fa_temp(.a(a[i]),.b(b[i]),.cin(c[i]),.s(S[i]),.cout(C[i]));
    end
endgenerate 
    
    
endmodule
