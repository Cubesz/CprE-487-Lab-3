`timescale 1ns / 1ps

module mac_2bit_tb();
    reg clk;
    reg rst;
    
    // 2-bit MAC: Data is 4 bits total (2A + 2B)
    parameter DATA_WIDTH = 2;
    
    reg master_ready;
    reg master_valid;
    reg [DATA_WIDTH*2-1 : 0] master_data; // 4 bits wide
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
    
    two_bit_mac #(.C_DATA_WIDTH(DATA_WIDTH)) DUT (
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
        $display("Starting 2-bit MAC Test");

        // Normal use test
        // Bias: 5
        // Op1: 1 * 1 = 1
        // Op2: -1 * 1 = -1
        // Op3: -2 * -2 = 4 (Max possible product)
        
        send_transaction(4'd5, 0); // Bias
        
        // 1 (01) and 1 (01)
        send_transaction({2'b01, 2'b01}, 0); 
        
        // -1 (11) and 1 (01)
        send_transaction({2'b11, 2'b01}, 0); 
        
        // -2 (10) and -2 (10)
        send_transaction({2'b10, 2'b10}, 1);
        
        check_result(5 + 1 - 1 + 4);

        $display("\nAll 2-bit tests completed!");
        $finish;
    end
endmodule