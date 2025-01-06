`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/02 13:30:01
// Design Name: 
// Module Name: gen_prod
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

//ÎÞ·ûºÅÊýbooth±àÂë16*16
module gen_prod #(
    parameter N = 16
    )(
    input [15:0] x,
    input [2:0] s,
    output reg [17:0] prod
    );
    
always @(*) begin
    case(s)
        3'b000,3'b111:
            prod = 18'b0;
        3'b010,3'b001:
            prod = {2'b00,x};
        3'b011:
            prod = {1'b0,x,1'b0};
        3'b110,3'b101:
            prod = {2'b11,~x}+1;
        3'b100:
            prod = {{1'b1,~x}+1,1'b0};
    endcase
end
    
endmodule
