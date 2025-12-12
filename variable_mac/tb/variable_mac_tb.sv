`timescale 1ns / 1ps

module variable_mac_tb();
    reg clk;
    reg rst;
    
    reg master_ready;
    reg master_valid;
    reg [15:0] master_data; // 8-bit Input + 8-bit Weight
    reg [1:0] master_tuser; // Precision Control: 0 = 8 bit, 1 = 4bit, 2 = 2bit
    reg master_last;
    
    wire slave_ready;
    wire slave_valid;
    wire [31:0] slave_data;
    wire slave_last;
    
    // Precision Constants
    localparam MODE_8BIT = 2'd0;
    localparam MODE_4BIT = 2'd1;
    localparam MODE_2BIT = 2'd2;

    // Clock Generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // DUT Instantiation
    variable_mac DUT (
        .ACLK(clk),
        .ARESETN(rst),
        .SD_AXIS_TREADY(slave_ready),
        .SD_AXIS_TDATA(master_data),
        .SD_AXIS_TLAST(master_last),
        .SD_AXIS_TUSER(master_tuser),
        .SD_AXIS_TVALID(master_valid),
        .SD_AXIS_TID(8'd0),
        
        .MO_AXIS_TVALID(slave_valid),
        .MO_AXIS_TDATA(slave_data),
        .MO_AXIS_TLAST(slave_last),
        .MO_AXIS_TREADY(master_ready),
        .MO_AXIS_TID()
    );

    // Task to send a transaction with specific precision mode
    task send_transaction(input [15:0] data, input [1:0] mode, input is_last);
        begin
            @(posedge clk);
            // Wait for DUT to be ready
            while (slave_ready == 0) @(posedge clk);

            master_valid <= 1;
            master_data  <= data;
            master_tuser <= mode;
            master_last  <= is_last;

            @(posedge clk);
            
            master_valid <= 0;
            master_last  <= 0;
        end
    endtask

    // Task to reset
    task reset_dut;
        begin
            $display("--- Resetting DUT ---");
            rst = 0;
            master_ready = 0;
            master_valid = 0;
            master_tuser = 0;
            #40;
            rst = 1;
            @(posedge clk);
            #5;
        end
    endtask

    // Task to check results
    task check_result(input signed [31:0] expected);
        begin
            master_ready = 1;
            while (slave_valid == 0) @(posedge clk);
            
            $display("Expected: %d | Actual: %d", expected, $signed(slave_data));
            
            if ($signed(slave_data) == expected) 
                $display("[PASS]");
            else 
                $display("[FAIL] !!!");
            
            @(posedge clk);
            master_ready = 0;
            #5;
        end
    endtask

    initial begin
        // Initialize
        rst = 0;
        master_ready = 0;
        master_valid = 0;
        master_data = 0;
        master_tuser = 0;
        master_last = 0;
        #40;
        rst = 1;
        #20;
        
        $display("Starting Variable Precision MAC Tests");

        // Test 1: Standard 8-bit Mode
        $display("\nTest 1: 8-Bit Mode");
        // Bias: 100
        send_transaction(16'd100, MODE_8BIT, 0); 
        
        // 10*10 = 100
        send_transaction({8'd10, 8'd10}, MODE_8BIT, 0); 
        
        // -5*20 = -100
        // -5 in 8-bit is 0xFB
        send_transaction({8'hFB, 8'd20}, MODE_8BIT, 1);
        
        // 100 + 100 - 100 = 100
        check_result(100);
        
        reset_dut();

        // Test 2: 4-Bit Mode
        $display("\nTest 2: 4-Bit Mode");
        // Bias: 50
        send_transaction(16'd50, MODE_4BIT, 0); 
        
        // Clean Data
        // Input: 2, Weight: 3 -> 6
        send_transaction({4'd0, 4'd2, 4'd0, 4'd3}, MODE_4BIT, 0);
        
        // Dirty Data (unneeded data in upper bits)
        // We want to send Input=2, Weight=3.
        // But some random values are present in the top nibble
        // Byte = 0xF2 (Input) and 0xC3 (Weight).
        // If logic is wrong (8-bit mode), this would be -14 * -13 = 182.
        // If logic is correct (4-bit mode), this is 2 * 3 = 6.
        send_transaction({8'hF2, 8'hC3}, MODE_4BIT, 1);
        
        // 50 + 6 + 6 = 62
        check_result(62);
        
        reset_dut();

       // Test 3: 2-Bit Mode
        $display("\nTest 3: 2-Bit Mode (Verifying Input Masking)");
        // Bias: 10
        send_transaction(16'd10, MODE_2BIT, 0); 
        
        // Input: 1 (01), Weight: 1 (01) -> 1
        send_transaction({6'd0, 2'b01, 6'd0, 2'b01}, MODE_2BIT, 0);
        
        // We want Input=-1 (11), Weight=1 (01). Product = -1.
        // Input Byte: 1010_1011 (0xAB). 2-bit mode sees 11 (-1).
        // Weight Byte: 1010_1001 (0xA9). 2-bit mode sees 01 (1).
        send_transaction({8'hAB, 8'hA9}, MODE_2BIT, 1);
        
        // 10 + 1 - 1 = 10
        check_result(10);
        
        reset_dut();

        // Test 4: Dynamic Switching (Layer-by-Layer simulation)
        $display("\nTest 4: Dynamic Switching (Bias -> 8bit -> 4bit -> 2bit)");
        
        // Load Bias (Mode doesn't matter for bias)
        send_transaction(16'd0, MODE_8BIT, 0); 
        
        // 8-bit Op: 10 * 10 = 100
        send_transaction({8'd10, 8'd10}, MODE_8BIT, 0);
        
        // Switch to 4-bit Op: 2 * 2 = 4 (Pass 0x12, 0x12 to ensure masking works)
        send_transaction({8'h12, 8'h12}, MODE_4BIT, 0);
        
        // Switch to 2-bit Op: -2 * 1 = -2 (Pass 0xFE, 0x01. 0xFE ends in 10 which is -2)
        send_transaction({8'hFE, 8'h01}, MODE_2BIT, 1); // TLAST=1
        
        // 0 + 100 + 4 - 2 = 102
        check_result(102);

        $display("All Tests Completed Successfully");
        $finish;
    end
endmodule