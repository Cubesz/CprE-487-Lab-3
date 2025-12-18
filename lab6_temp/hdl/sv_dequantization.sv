`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.11.2025 16:42:14
// Design Name: 
// Module Name: sv_dequantization
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


module sv_dequantization #(parameter C_DATA_WIDTH = 32, parameter C_TID_WIDTH = 1, parameter C_OUT_WIDTH = 8) (
        output S_AXIS_TREADY,
        input [C_DATA_WIDTH-1 : 0] S_AXIS_TDATA,
        input S_AXIS_TLAST,
        input [C_TID_WIDTH-1 : 0] S_AXIS_TID,
        input S_AXIS_TVALID,
        
        input relu,
        input [C_DATA_WIDTH-1 : 0] q_scale,
        input [C_OUT_WIDTH-1 : 0] q_zero,
        
        input M_AXIS_TREADY,
        output [C_OUT_WIDTH-1 : 0] M_AXIS_TDATA,
        output M_AXIS_TLAST,
        output [C_TID_WIDTH-1 : 0] M_AXIS_TID,
        output M_AXIS_TVALID,
        
        input clk,
        input rst
    );
    
    // Q32.0 * Q0.32 = Q32.32
    
    // Q32.0 * Q0.18
    // assumiming q_scale [2^-1, 2^-5] bits are 0
    
    wire stall;
    
    wire signed [31:0] scaled;
    // 4 pipeline stages
    // assuming [2^-1, 2^-5] bits are all 0.
    // scaled is bits [28 : 18] of actual product.
    mult_q32d0_q0d18 fxedP_mult (
        .CLK(clk),
        .CE(~stall),
        .A($signed(S_AXIS_TDATA)),
        .B(q_scale[26 : 14]),
        .P(scaled)
    );

    
    wire signed [31:0] post_cond_relued;
    assign post_cond_relued = relu ? (scaled[$size(scaled) - 1] ? 0 : scaled) : scaled;
    
    // 1 pipeline stage
    wire signed [31:0] post_zp_adjusted;
    zp_adder zerop_adder (
        .CLK(clk),
        .CE(~stall),
        .A(post_cond_relued),
        .B(q_zero),
        .S(post_zp_adjusted)
    );
    
    reg signed [7:0] post_saturate;
    
    always @* begin
        if (|post_zp_adjusted[31:7] == 0 || &post_zp_adjusted[31:7] == 1)
            post_saturate = post_zp_adjusted[7:0];
        else if (post_zp_adjusted[31] == 0 && |post_zp_adjusted[31:7] != 0)
            post_saturate = 127;
        else
            post_saturate = -128;
    end
    
    
    typedef struct packed {
        logic [C_TID_WIDTH-1 : 0] tid;
        logic tlast;
        logic tvalid;
    } piped_metadata_t;
    
    piped_metadata_t [6:0] p_pipelines;
    
    always @(posedge clk) begin
        if (rst) begin
            p_pipelines = 0;
        end
        if (!stall) begin
            p_pipelines[0] <= '{S_AXIS_TID, S_AXIS_TLAST, S_AXIS_TVALID};
            p_pipelines[1] <= p_pipelines[0];
            p_pipelines[2] <= p_pipelines[1];
            p_pipelines[3] <= p_pipelines[2];
            p_pipelines[4] <= p_pipelines[3];
            p_pipelines[5] <= p_pipelines[4];
            p_pipelines[6] <= p_pipelines[5];
       end
    end
    
    assign stall = rst | (p_pipelines[6].tvalid & ~M_AXIS_TREADY);
    assign M_AXIS_TVALID = p_pipelines[6].tvalid;
    assign M_AXIS_TLAST = p_pipelines[6].tlast;
    assign M_AXIS_TID = p_pipelines[6].tid;
    assign M_AXIS_TDATA = post_saturate;
    assign S_AXIS_TREADY = ~stall;
    
endmodule
