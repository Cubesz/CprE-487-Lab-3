`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2025 16:09:02
// Design Name: 
// Module Name: new_piped_mac_tb
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

module new_piped_mac_tb(
        
    );
    reg clk;
    reg rst;
    
    reg master_ready;
    reg master_valid;
    reg [15:0] master_data;
    reg [31:0] master_tuser;
    reg master_last;
    
    wire slave_ready;
    wire slave_valid;
    wire [31:0] slave_data;
    wire slave_last;
    
    
    initial begin
        clk = 0;
    end
    
    always #5 clk = ~clk;
    
    piped_mac DUT (
        .ACLK(clk),
        .ARESETN(rst),
        .SD_AXIS_TREADY(slave_ready),
        .SD_AXIS_TDATA(master_data),
        .SD_AXIS_TLAST(master_last),
        .SD_AXIS_TVALID(master_valid),
        .SD_AXIS_TUSER(master_tuser),
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
            #5;
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
            #5;
        end
    endtask


    initial begin
        rst = 0; // reset active
        master_ready = 0;
        master_valid = 0;
        master_data = 0;
        master_last = 0;
        master_tuser = 0;
        #40;
        rst = 1;
        #20
        $display("Starting");

        $display("\nTest 0");

        

        master_valid = 1;
        master_data = -600;
        #10
        
        master_data[15:8] = -50;
        master_data[7:0] = 38;
        #10
        
        
        master_data[15:8] = 5;
        master_data[7:0] = 2;
        master_last = 1;
        #10
        
        #20
        
        // test duel plex bias load AND receiving output at same time
        // new bias load with multiply add but also expecting to get the output
        master_ready = 1;
        master_last = 0;
        master_data = 99;
        master_tuser = 99;
        $display("Expected result: %d", -600 + (-50 * 38) + (5 * 2));
        $display("Actual result: %d", $signed(slave_data));
        if ($signed(slave_data) == $signed(-600 + (50 * 38) + (5*2))) $display("[PASS]");
        else $display("[FAIL]");
        #10
        
        //check_result(-600 + -50 * 38 + 5*2);
        master_data[15:8] = 37;
        master_data[7:0] = 3;
        #10
        master_data[15:8] = 18;
        master_data[7:0] = 23;
        master_last = 1;
        #10
        master_valid = 0;
        master_last = 0;
        check_result(99 + 37*3 + 18*23);
  
        $display("\nTest 1");
        
        // send bias and some weights
        
        reset_dut();

        master_data = 5;
        master_valid = 1;
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

        // TEST: A typical use case with multiple accumulations
        $display("\nTEST 2: Typical Use");
        // bias of -1028, we need to split it up
        // -128*10 + 126 * 2
        send_transaction(-1028, 0); // Bias
        
        send_transaction({$signed(-8'd122), $signed(-8'd15)}, 0);
        send_transaction({$signed(8'd119),  $signed(-8'd3)}, 0);
        send_transaction({$signed(-8'd107), $signed(8'd13)}, 1);
        check_result(-1028 + (-15 * -122) + (-3 * 119) + (13 * -107));

        reset_dut();

        // TEST: Maximum positive value
        $display("\nTEST 3: Maximum Value Test");
        send_transaction(5000, 0); // Bias
        send_transaction({$signed(-8'd128), $signed(-8'd128)}, 1);
        check_result(5000 + (-128 * -128));

        reset_dut();

        // TEST: Maximum negative value
        $display("\nTEST 4: Minimum Value Test");
        send_transaction(-2000, 0); // Bias
        send_transaction({$signed(-8'd128), $signed(8'd127)}, 0);
        send_transaction({$signed(-8'd100), $signed(8'd120)}, 1);
        check_result(-2000 + (127 * -128) + (120 * -100));
        
        // TEST: Test back to back to back
        $display("\nTEST 5: Back to back to back");
        master_valid = 1;
        master_ready = 1;
        master_data = 10;
        #10
        master_data[15:8] = -13;
        master_data[7:0] = -1;
        #10
        master_data[15:8] = 9;
        master_data[7:0] = 3;
        #10
        master_data[15:8] = 1;
        master_data[7:0] = 127;
        master_last = 1;
        #10
        master_data = 33;
        master_last = 0;
        #10
        master_data[15:8] = 1;
        master_data[7:0] = 2;
        master_last = 1;
        #10
        master_last = 1;
        master_data = 64;
        // Expecting first to be done
        $display("Actual result: %d", $signed(slave_data));
        $display("Expected result: %d", $signed(177));        
        #10
        master_last = 0;
        master_valid = 0;
        #10
        // Expecting second to be done
        $display("Actual result: %d", $signed(slave_data));
        $display("Expected result: %d", $signed(35));        
        #10
        // Expecting third to be done
        $display("Actual result: %d", $signed(slave_data));
        $display("Expected result: %d", $signed(64));               
        #10

        // TEST: Test back to back to back with stall
        $display("\n TEST 6: Back to back to back with a stall");
        master_valid = 1;
        master_ready = 0;
        master_data = 10;
        #10
        master_data[15:8] = -13;
        master_data[7:0] = -1;
        #10
        master_data[15:8] = 9;
        master_data[7:0] = 3;
        #10
        master_data[15:8] = 1;
        master_data[7:0] = 127;
        master_last = 1;
        #10
        master_data = 33;
        master_last = 0;
        #10
        master_data[15:8] = 1;
        master_data[7:0] = 2;
        master_last = 1;
        #10
        master_last = 1;
        master_data = 64;
        // Expecting first to be done, but we are not taking the data (master_tready = 0). Thus, slave_tready should be false as it should not be willing to proceed unless we are ready to take this data
        $display("Actual result: %d", $signed(slave_data));
        $display("Expected result: %d", $signed(177));
        $display("Actual slave tready: %d", slave_ready);
        $display("Expected slave tready: 0");
        #10
        master_last = 1;
        master_data = 64;
        master_ready = 1; // lets take it now
        #1
        $display("Actual slave tready: %d", slave_ready);
        $display("Expected slave tready: 1");
        #9
        master_last = 0;
        master_valid = 0;
        #10
        // Expecting second to be done
        $display("Actual result: %d", $signed(slave_data));
        $display("Expected result: %d", $signed(35));
        #10
        // Expecting third to be done
        $display("Actual result: %d", $signed(slave_data));
        $display("Expected result: %d", $signed(64));        
        #10

        
        

        $display("\nAll tests completed!");
        $finish;
    end
    

endmodule
