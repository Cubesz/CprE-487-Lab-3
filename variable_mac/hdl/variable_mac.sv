`timescale 1ns / 1ps

module variable_mac (
    input logic ACLK,
    input logic ARESETN,
    
    // AXI STREAM SLAVE (Input)
    output reg SD_AXIS_TREADY,
    input [15:0] SD_AXIS_TDATA,
    input SD_AXIS_TLAST,
    input [1:0] SD_AXIS_TUSER,  // Control Signal: 0 = 8 bit, 1 = 4 bit, 2 = 2 bit
    input SD_AXIS_TVALID,
    input [7:0] SD_AXIS_TID,
    
    // AXI STREAM MASTER (Output)
    output MO_AXIS_TVALID,
    output [31:0] MO_AXIS_TDATA,
    output MO_AXIS_TLAST,
    input MO_AXIS_TREADY,
    output [7:0] MO_AXIS_TID
);

    // Precision Mode Definitions
    localparam MODE_8BIT = 2'd0;
    localparam MODE_4BIT = 2'd1;
    localparam MODE_2BIT = 2'd2;

    typedef enum logic { LOAD_BIAS, MAC_OP } STATE_TYPE;
    STATE_TYPE state;
    
    typedef enum logic [1:0] { LOAD=0, MAC=1, NOOP=2 } instr_t;
    instr_t instruction;

    // Data Unpacking
    wire signed [7:0] raw_inp = SD_AXIS_TDATA[15:8];
    wire signed [7:0] raw_weight = SD_AXIS_TDATA[7:0];
    
    logic signed [7:0] op_a, op_b;
    
    always_comb begin
        case (SD_AXIS_TUSER)
            MODE_4BIT: begin
                // Mask upper 4 bits (Sign Extend 4 bit value)
                op_a = {{4{raw_inp[3]}}, raw_inp[3:0]};
                op_b = {{4{raw_weight[3]}}, raw_weight[3:0]};
            end
            MODE_2BIT: begin
                // Mask upper 6 bits (Sign Extend 2 bit value)
                op_a = {{6{raw_inp[1]}}, raw_inp[1:0]};
                op_b = {{6{raw_weight[1]}}, raw_weight[1:0]};
            end
            default: begin // MODE_8BIT
                op_a = raw_inp;
                op_b = raw_weight;
            end
        endcase
    end
    
    // Bias is always full 16-bit
    wire signed [15:0] bias_val = $signed(SD_AXIS_TDATA);
    
    wire stall;
    wire [31:0] accumulator_out;
    assign MO_AXIS_TDATA = accumulator_out;
    

    mac_math_core_var #(.WIDTH(8)) math_unit (
        .CLK(ACLK),
        .CE(~stall),
        .SEL(instruction),
        .A(op_a),
        .B(op_b),
        .C(bias_val),
        .P(accumulator_out)
    );

    // Pipeline Control
    reg p1, p2, output_ready;
    always @(posedge ACLK) begin
        if (!ARESETN) begin
            p1 <= 0; p2 <= 0; output_ready <= 0;
        end else if (!stall) begin
            p1 <= SD_AXIS_TVALID & SD_AXIS_TLAST;
            p2 <= p1;
            output_ready <= p2;
        end
    end
    
    assign stall = ~ARESETN | (output_ready & ~MO_AXIS_TREADY);
    assign MO_AXIS_TVALID = output_ready & ARESETN;
    assign MO_AXIS_TLAST = output_ready & ARESETN;
    assign MO_AXIS_TID = 0;

    // Instruction Decode
    always @* begin
        if (state == LOAD_BIAS) instruction = LOAD;
        else instruction = MAC;
        
        if (!SD_AXIS_TVALID) instruction = NOOP;
        
        SD_AXIS_TREADY = !stall && ARESETN;
    end

    always @(posedge ACLK) begin
        if (!ARESETN) state <= LOAD_BIAS;
        else case (state)
            LOAD_BIAS: if (SD_AXIS_TVALID && !stall && !SD_AXIS_TLAST) state <= MAC_OP;
            MAC_OP:    if (SD_AXIS_TVALID && !stall && SD_AXIS_TLAST) state <= LOAD_BIAS;
        endcase
    end
endmodule

// Helper for Variable MAC
module mac_math_core_var #(parameter WIDTH=8)(
    input logic CLK, CE,
    input logic [1:0] SEL,
    input signed [WIDTH-1:0] A, B,
    input signed [15:0] C,
    output reg signed [31:0] P
);
    (* use_dsp = "yes" *) wire signed [WIDTH*2-1:0] product;
    assign product = A * B;
    
    always @(posedge CLK) begin
        if (CE) case (SEL)
            0: P <= C;
            1: P <= P + product;
        endcase
    end
endmodule