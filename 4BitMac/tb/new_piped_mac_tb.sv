`timescale 1ns / 1ps

module mac_4bit_tb();
    reg clk;
    reg rst;
    
    parameter DATA_WIDTH = 4;
    
    reg master_ready;
    reg master_valid;
    reg [DATA_WIDTH*2-1 : 0] master_data; // 8 bits wide
    reg [31:0] master_tuser;
    reg master_last;
    
    wire slave_ready;
    wire slave_valid;
    wire [31:0] slave_data;
    wire slave_last;
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    four_bit_mac #(.C_DATA_WIDTH(DATA_WIDTH)) DUT (
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
        .MO_AXIS_TREADY(master_ready),
        .MO_AXIS_TID()
    );

    task send_transaction(input [DATA_WIDTH*2-1 : 0] data, input is_last);
        begin
            @(posedge clk);
            while (slave_ready == 0) @(posedge clk);
            master_valid <= 1;
            master_data  <= data;
            master_last  <= is_last;
            @(posedge clk);
            master_valid <= 0;
            master_last  <= 0;
        end
    endtask

    task reset_dut;
        begin
            $display("--- Resetting DUT ---");
            rst = 0;
            master_ready = 0;
            master_valid = 0;
            #40;
            rst = 1;
            @(posedge clk);
            #5;
        end
    endtask

    task check_result(input signed [31:0] expected);
        begin
            master_ready = 1;
            while (slave_valid == 0) @(posedge clk);
            $display("Expected: %d | Actual: %d", expected, $signed(slave_data));
            if ($signed(slave_data) == expected) $display("[PASS]");
            else $display("[FAIL]");
            @(posedge clk);
            master_ready = 0;
            #5;
        end
    endtask

    initial begin
        rst = 0;
        master_ready = 0;
        master_valid = 0;
        master_data = 0;
        master_last = 0;
        #40;
        rst = 1;
        #20
        $display("Starting 4-bit MAC Test");

        // Basic Accumulation
        // Bias: 10
        // Op1: 2 * 3 = 6
        // Op2: -3 * 2 = -6
        
        send_transaction(8'd10, 0);
        
        // 2 (0010) and 3 (0011) -> 0010_0011
        send_transaction({4'd2, 4'd3}, 0); 
        
        // -3 (1101) and 2 (0010) -> 1101_0010
        send_transaction({4'd13, 4'd2}, 1); 
        
        check_result(10 + (2*3) + (-3*2));

        reset_dut();

        // Max/Min Check 
        // Bias: -50
        // Op1: -8 * 7 = -56 (Max negative * Max positive)
        // Op2: -8 * -8 = 64 (Max square)
        
        send_transaction(-8'd50, 0); // Bias
        
        // -8 (1000) and 7 (0111)
        send_transaction({4'b1000, 4'b0111}, 0);
        
        // -8 (1000) and -8 (1000)
        send_transaction({4'b1000, 4'b1000}, 1);
        
        check_result(-50 + (-56) + (64));

        $display("\nAll 4-bit tests completed!");
        $finish;
    end
endmodule