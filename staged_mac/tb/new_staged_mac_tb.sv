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

    // Task to send a single AXI-Stream transaction
    task send_transaction(input [15:0] data, input is_last);
        begin
            @(posedge clk);
            // Wait until the DUT is ready to accept data
            while (slave_ready == 0) begin
                @(posedge clk);
            end

            master_valid <= 1;
            master_data  <= data;
            master_last  <= is_last;

            @(posedge clk);

            master_valid <= 0;
            master_last  <= 0;
        end
    endtask

    // Task to reset the DUT between tests
    task reset_dut;
        begin
            $display("\nResetting DUT for next test");
            rst = 0;
            master_ready = 0;
            #40;
            rst = 1;
            @(posedge clk);
        end
    endtask

    // Task to wait for and check the final result
    task check_result(input signed [31:0] expected);
        begin
            master_ready = 1; // Signal that we are ready to accept the result
            while (slave_valid == 0) begin
                @(posedge clk);
            end

            $display("Expected result: %d", expected);
            $display("Actual result:   %d", $signed(slave_data));
            if ($signed(slave_data) == expected) $display("[PASS]");
            else $display("[FAIL]");

            @(posedge clk);
            master_ready = 0;
        end
    endtask


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

        $display("\nTest 0");


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
        check_result(5 + (-10 * 5) + (25 * 100));

        reset_dut();

        // TEST 1: A typical use case with multiple accumulations
        $display("\nTEST 1: Typical Use");
        send_transaction(-1093, 0); // Bias
        send_transaction({$signed(-8'd122), $signed(-8'd15)}, 0);
        send_transaction({$signed(8'd119),  $signed(-8'd3)}, 0);
        send_transaction({$signed(-8'd107), $signed(8'd13)}, 1);
        check_result(-1093 + (-15 * -122) + (-3 * 119) + (13 * -107));

        reset_dut();

        // TEST 2: Maximum positive value
        $display("\nTEST 2: Maximum Value Test");
        send_transaction(5000, 0); // Bias
        send_transaction({$signed(-8'd128), $signed(-8'd128)}, 1);
        check_result(5000 + (-128 * -128));

        reset_dut();

        // TEST 3: Maximum negative value
        $display("\nTEST 3: Minimum Value Test");
        send_transaction(-2000, 0); // Bias
        send_transaction({$signed(-8'd128), $signed(8'd127)}, 0);
        send_transaction({$signed(-8'd100), $signed(8'd120)}, 1);
        check_result(-2000 + (127 * -128) + (120 * -100));

        $display("\nAll tests completed!");
        $finish;
    end
    

endmodule
