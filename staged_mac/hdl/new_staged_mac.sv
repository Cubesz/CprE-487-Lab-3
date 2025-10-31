`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2025 15:24:04
// Design Name: 
// Module Name: new_staged_mac
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

module new_staged_mac #(parameter C_DATA_WIDTH = 8) (
        input ACLK,
        input ARESETN,
        
        output reg SD_AXIS_TREADY,
        input [C_DATA_WIDTH*2-1 : 0] SD_AXIS_TDATA,
        input SD_AXIS_TLAST,
        input SD_AXIS_TUSER,
        input SD_AXIS_TVALID,
        input [7:0] SD_AXIS_TID,
        
        output reg MO_AXIS_TVALID,
        output [31:0] MO_AXIS_TDATA,
        output reg MO_AXIS_TLAST,
        input MO_AXIS_TREADY,
        output [7:0] MO_AXIS_TID
    );
    assign MO_AXIS_TID = 0;
    typedef enum logic [1:0] { LOAD_BIAS, MAC_W_AND_I, OUTPUT_RES } STATE_TYPE;
    typedef enum logic [1:0] {
        LOAD = 0,
        MAC = 1,
        HOLD = 2
    } instruction_t;
    typedef struct packed {
        logic signed [C_DATA_WIDTH - 1 : 0] inp;
        logic signed [C_DATA_WIDTH - 1 : 0] weight;
    } input_data_t;
    
    STATE_TYPE state;
    instruction_t instruction;
    input_data_t input_data;
    
    wire signed [15:0] new_bias;
    assign input_data = input_data_t'(SD_AXIS_TDATA);
    assign new_bias = SD_AXIS_TDATA;
    
    reg signed [31:0] accumulator;
    assign MO_AXIS_TDATA = accumulator;

    always @(posedge ACLK) begin
        if (!ARESETN) begin
            // Reset accumulator
            accumulator <= 32'sd0;
        end
        else begin
            if (instruction == LOAD) begin
                // Load a new value (bias).
                accumulator <= new_bias;
            end
            else if (instruction == MAC) begin
                // MAC
                accumulator <= accumulator + (input_data.inp * input_data.weight);
            end
            // If instruction is HOLD, do nothing
        end
    end

    // dsp48_load_mac_hold_comb com (
    //     .CLK(ACLK),
    //     .SEL(instruction),
    //     .A(input_data.inp),
    //     .B(input_data.weight),
    //     .C(new_bias),
    //     .P(accumulator)
    // );

    

    always @* begin
        SD_AXIS_TREADY = 1;
        if (state == OUTPUT_RES && ARESETN) begin
            MO_AXIS_TVALID = 1;
            MO_AXIS_TLAST = 1;
        end
        else begin
            MO_AXIS_TVALID = 0;
            MO_AXIS_TLAST = 0;
        end
        
        
        if (state == OUTPUT_RES) begin

            if (MO_AXIS_TREADY && SD_AXIS_TVALID) begin
                instruction = LOAD;
            end
            else if (!MO_AXIS_TREADY) begin // if master isn't ready to receive then hold
                instruction = HOLD;
                SD_AXIS_TREADY = 0;
            end
            else begin
                instruction = LOAD; // don't care here. Once tvalid is a yea and the state changes, this should change to what it should be.
            end
        end
        else if (state == LOAD_BIAS) begin
            instruction = LOAD;
        end
        else begin
            instruction = MAC;
        end
        
        if (!SD_AXIS_TVALID) begin
            instruction = HOLD;
        end
        
        if (!ARESETN) begin
            SD_AXIS_TREADY = 0;
        end

    end

    
    always @(posedge ACLK) begin

        if (ARESETN == 0) begin // is in reset
            //state <= WAIT_FOR_BIAS;
            state <= LOAD_BIAS;
        end
        else begin
            case (state)
                LOAD_BIAS: begin
                    if (SD_AXIS_TVALID) begin
                        state <= MAC_W_AND_I;
                        if (SD_AXIS_TLAST) begin
                            state <= OUTPUT_RES;
                        end
                    end
                end
                MAC_W_AND_I: begin
                    if (SD_AXIS_TVALID && SD_AXIS_TLAST) begin
                        state <= OUTPUT_RES;
                    end
                end
                OUTPUT_RES: begin
                    if (MO_AXIS_TREADY) begin // it should get our result... move on
                        if (SD_AXIS_TVALID && SD_AXIS_TLAST) begin
                            state <= OUTPUT_RES;
                        end
                        else if (SD_AXIS_TVALID) begin
                            state <= MAC_W_AND_I;
                        end
                        else begin
                            state <= LOAD_BIAS;
                        end
                    end
                end
                default: begin
                    //state <= WAIT_FOR_BIAS;
                    state <= LOAD_BIAS;
                end
            endcase
        end
    end
    
    
endmodule