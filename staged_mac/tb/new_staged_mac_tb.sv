`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2025 16:09:02
// Design Name: 
// Module Name: new_staged_mac_tb
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


module new_staged_mac_tb(
        
    );
    
    reg clk;
    reg rst;
    
    reg master_ready;
    reg master_valid;
    reg [15:0] master_data;
    reg master_last;
    
    wire slave_ready;
    wire slave_valid;
    wire [31:0] slave_data;
    wire slave_last;
    
    
    initial begin
        clk = 0;
    end
    
    always #5 clk = ~clk;
    
    new_staged_mac DUT (
        .ACLK(clk),
        .ARESETN(rst),
        .SD_AXIS_TREADY(slave_ready),
        .SD_AXIS_TDATA(master_data),
        .SD_AXIS_TLAST(master_last),
        .SD_AXIS_TVALID(master_valid),
        .MO_AXIS_TVALID(slave_valid),
        .MO_AXIS_TDATA(slave_data),
        .MO_AXIS_TLAST(slave_last),
        .MO_AXIS_TREADY(master_ready)
    );
    
    initial begin
        rst = 0; // reset active
        master_ready = 0;
        master_valid = 0;
        master_data = 0;
        master_last = 0;
        #40;
        rst = 1;
        #20
        $display("Starting");
        
        $display("Test 1");
        
        // send bias and some weights
        master_valid = 1;
        master_data = 5;
        #10
        
        master_data[15:8] = -10;
        master_data[7:0] = 5;
        #10
        
        master_data[15:8] = 25;
        master_data[7:0] = 100;
        master_last = 1;
        #10
        
        master_valid = 0;
        master_last = 0;
        master_ready = 1;
        $display("We got: %d", slave_data);
        $display("Should be: %d", 5 + (-10 * 5) + 25*100);
        #10
        
        
        $finish;
    end
    
    
endmodule
