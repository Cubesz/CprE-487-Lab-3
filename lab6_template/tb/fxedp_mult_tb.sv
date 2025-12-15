`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.11.2025 11:27:53
// Design Name: 
// Module Name: fxedp_mult_tb
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


module fxedp_mult_tb(
        output whatever;
    );


    reg clk;    
    

    
    reg signed [31:0] data;

    reg [31:0] q_scale;
    
    wire signed [10:0] scaled;
    // 4 pipeline stages
    // assuming [2^-1, 2^-5] bits are all 0.
    // scaled is bits [28 : 18] of actual product.
    mult_q32d0_q0d18 fxedP_mult (
        .CLK(clk),
        .A($signed(data)),
        .B(q_scale[26 : 14]),
        .P(scaled)
    );
    
    initial begin
        #5
        
        data = 1533;
        q_scale = 'b0000001110001010000000000000000; // 2^-7 2^-8 2^-9 2^-13 2^-15 // 0.01382446289
        
        #2
        data = 0;
    end
    
    initial begin
        clk = 0;
        forever begin
            #2 clk = ~clk;
        end
    end
    
    assign whatever = 1;
    
endmodule : fxedp_mult_tb

