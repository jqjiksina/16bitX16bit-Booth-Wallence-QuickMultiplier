`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/13 11:22:20
// Design Name: 
// Module Name: u74182
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


module u74182(
    input[3:0] P,
    input[3:0] G,
    input cin,
    output[4:1] C,
    output Ps,
    output Gs
    );
    
assign C[1] = G[0] | P[0]&cin;
assign C[2] = G[1] | P[1]&G[0] | P[1]&P[0]&cin;
assign C[3] = G[2] | P[2]&G[1] | P[2]&P[1]&G[0] | P[2]&P[1]&P[0]&cin;
assign C[4] = Gs | Ps&cin;
assign Ps = P[3]&P[2]&P[1]&P[0];
assign Gs = G[3] | P[3]&G[2] | P[3]&P[2]&G[1] | P[3]&P[2]&P[1]&G[0];

endmodule
