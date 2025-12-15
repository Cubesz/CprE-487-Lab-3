//`timescale 0.01ps / 0.001ps
//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.11.2025 14:06:21
// Design Name: 
// Module Name: sv_conv_mac
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


module sv_conv_mac #(parameter C_DATA_WIDTH = 8, parameter C_OUTPUT_DATA_WIDTH = 32) (
        input ACLK,
        input ARESETN,
        
        output reg SD_AXIS_TREADY,
        input [C_DATA_WIDTH*2-1 : 0] SD_AXIS_TDATA,
        input SD_AXIS_TLAST,
        input SD_AXIS_TVALID,
        
        input [C_OUTPUT_DATA_WIDTH-1 : 0] bias,
        
        output MO_AXIS_TVALID,
        output [C_OUTPUT_DATA_WIDTH-1 : 0] MO_AXIS_TDATA,
        output MO_AXIS_TLAST,
        input MO_AXIS_TREADY
    );
    
    typedef enum logic { LOAD_PRODUCT_PLUS_BIAS, MAC_W_AND_I } STATE_TYPE;
    
    
    STATE_TYPE state;
    

    
    typedef enum logic [1:0] {
        LOAD = 0,
        MAC = 1,
        NOOP = 2
    } custom_mult_add_instruction_t;
    
    typedef struct packed {
        logic signed [C_DATA_WIDTH - 1 : 0] inp;
        logic signed [C_DATA_WIDTH - 1 : 0] weight;
    } input_data_t;
    
    custom_mult_add_instruction_t instruction;
    
    wire [47:0] accumulator_out;
    assign MO_AXIS_TDATA = accumulator_out[C_OUTPUT_DATA_WIDTH-1 : 0]; // it shouldn't sample it until its ready
    
    input_data_t input_mult_data;
    wire signed [31:0] new_bias;
    assign new_bias = bias;
    assign input_mult_data = input_data_t'(SD_AXIS_TDATA);
    wire stall; // active high
    dsp48_custom_mult_add_piped mult_add (
        .CLK(ACLK),
        .CE(~stall),
        .SEL(instruction),
        .A(input_mult_data.inp),
        .B(input_mult_data.weight),
        .C(new_bias),
        .P(accumulator_out)
    );
    // pipeline parallel with dsp slice
    reg p1, p2, output_ready;
    always @(posedge ACLK) begin
        if (ARESETN == 0) begin
            p1 <= 0;
            p2 <= 0;
            output_ready <= 0;
        end
       if (!stall) begin
            p1 <= SD_AXIS_TVALID & SD_AXIS_TLAST;
            p2 <= p1;
            output_ready <= p2;
       end
    end
    
    assign stall = ~ARESETN | (output_ready & ~MO_AXIS_TREADY);
    assign MO_AXIS_TVALID = output_ready & ARESETN;
    assign MO_AXIS_TLAST = output_ready & ARESETN;
    
    always @* begin

        
        // in the case of a stall, the instruction doesn't matter as its stalled and shouldn't enter the pipeline anyways
        if (state == LOAD_PRODUCT_PLUS_BIAS) begin
            instruction = LOAD;
        end
        else begin
            instruction = MAC;
        end
        
        if (!SD_AXIS_TVALID) begin
            instruction = NOOP;
        end
        
        if (/*SD_AXIS_TVALID &*/ !stall) begin
            SD_AXIS_TREADY = 1;
        end
        else begin
            SD_AXIS_TREADY = 0;
        end
        
        if (!ARESETN) begin
            SD_AXIS_TREADY = 0;
        end
        
    end

    
    always @(posedge ACLK) begin
        if (ARESETN == 0) begin // is in reset
            //state <= WAIT_FOR_BIAS;
            state <= LOAD_PRODUCT_PLUS_BIAS;
        end
        else begin
            case (state)
                LOAD_PRODUCT_PLUS_BIAS: begin
                    if (SD_AXIS_TVALID && !stall && !SD_AXIS_TLAST) begin
                        state <= MAC_W_AND_I;
                    end;
                end
                MAC_W_AND_I: begin
                    if (SD_AXIS_TVALID && !stall && SD_AXIS_TLAST) begin
                        state <= LOAD_PRODUCT_PLUS_BIAS;
                    end
                end
                default: begin
                    //state <= WAIT_FOR_BIAS;
                    state <= LOAD_PRODUCT_PLUS_BIAS;
                end
            endcase
        end
    end
    
    
endmodule
