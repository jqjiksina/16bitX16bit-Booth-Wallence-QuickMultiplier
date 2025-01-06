`timescale 1ns / 1ps

module fa(
    input a,
    input b,
    input cin,
    output s,
    output cout
    );
    wire mid;
    
    assign mid = a ^ b;
    assign s = mid ^ cin;
    assign cout = (mid & cin) | (a & b);
    
endmodule