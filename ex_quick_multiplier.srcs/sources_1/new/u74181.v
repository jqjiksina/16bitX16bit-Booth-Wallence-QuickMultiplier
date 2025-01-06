`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/13 00:11:24
// Design Name: 
// Module Name: u74181
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


module u74181(
    input[3:0] A,
    input[3:0] B,
    input cin,
    output[3:0] S,
    output cout,
    output Ps,
    output Gs);
    
wire[3:0] P,G;
wire[3:0] C;
assign C[0] = cin;

genvar i;
generate 
    for (i = 0; i <= 3; i = i + 1) begin:data_shift
        assign P[i] = A[i] ^ B[i];
        assign G[i] = A[i] & B[i];  
        assign S[i] = P[i] ^ C[i];
    end
endgenerate

assign C[1] = G[0] | P[0]&cin;
assign C[2] = G[1] | P[1]&G[0] | P[1]&P[0]&cin;
assign C[3] = G[2] | P[2]&G[1] | P[2]&P[1]&G[0] | P[2]&P[1]&P[0]&cin;
assign cout = Gs | Ps&cin;
assign Ps = P[3]&P[2]&P[1]&P[0];
assign Gs = G[3] | P[3]&G[2] | P[3]&P[2]&G[1] | P[3]&P[2]&P[1]&G[0];

endmodule
