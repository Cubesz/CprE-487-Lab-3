`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.10.2025 23:55:57
// Design Name: 
// Module Name: piped_mac_wrapper
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


module piped_mac_wrapper #(parameter C_DATA_WIDTH = 8)(
        input ACLK,
        input ARESETN,
        
        output SD_AXIS_TREADY,
        input [C_DATA_WIDTH*2-1 : 0] SD_AXIS_TDATA,
        input SD_AXIS_TLAST,
        input [15:0] SD_AXIS_TUSER,
        input SD_AXIS_TVALID,
        input [7:0] SD_AXIS_TID,
        
        output MO_AXIS_TVALID,
        output [31:0] MO_AXIS_TDATA,
        output MO_AXIS_TLAST,
        input MO_AXIS_TREADY,
        output [7:0] MO_AXIS_TID
    );
    
    piped_mac #(.C_DATA_WIDTH(C_DATA_WIDTH)) our_piped_mac (
        .ACLK(ACLK),
        .ARESETN(ARESETN),
        .SD_AXIS_TREADY(SD_AXIS_TREADY),
        .SD_AXIS_TDATA(SD_AXIS_TDATA),
        .SD_AXIS_TLAST(SD_AXIS_TLAST),
        .SD_AXIS_TUSER(SD_AXIS_TUSER),
        .SD_AXIS_TVALID(SD_AXIS_TVALID),
        .SD_AXIS_TID(SD_AXIS_TID),
        .MO_AXIS_TVALID(MO_AXIS_TVALID),
        .MO_AXIS_TDATA(MO_AXIS_TDATA),
        .MO_AXIS_TLAST(MO_AXIS_TLAST),
        .MO_AXIS_TREADY(MO_AXIS_TREADY),
        .MO_AXIS_TID(MO_AXIS_TID)
    );
    
    
endmodule