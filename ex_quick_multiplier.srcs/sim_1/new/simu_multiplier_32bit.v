`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/06 13:53:52
// Design Name: 
// Module Name: simu_multiplier_32bit
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


module simu_multiplier_32bit;

reg [15:0] x,y;
wire [31:0] z;

top u1(.x(x),.y(y),.z(z));

initial begin
    x = 16'd78;
    y = 16'd996;
    #10
    x = 16'd45;
    y = 16'd4185;
    #10
    x = 16'hffff;
    y = 16'hffff;
    #10
    x = 16'hfe1e;
    y = 16'd0;
    #10
    x = 16'hfe1e;
    y = 16'd1;
    #10
    x = 16'hfe1e;
    y = 16'hfe1e;
end

endmodule
