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

//`define USEDSPMACRO

module plexed_staged_mac #(parameter C_DATA_WIDTH = 8) (
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
        DC = 'x
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
    
    wire signed [31:0] new_accumulated;
    reg signed [31:0] accumulator;
    assign MO_AXIS_TDATA = accumulator;

    wire signed [31:0] bias_or_accumulated;
    assign bias_or_accumulated = (instruction == MAC) ? accumulator : new_bias;
    
    wire signed [C_DATA_WIDTH - 1 : 0] new_input;
    wire signed [C_DATA_WIDTH - 1 : 0] new_weight;
    assign new_input = (instruction == LOAD) ? 0 : input_data.inp; // only one of these MUXs here is actually needed (0 * x = 0)
    assign new_weight = (instruction == LOAD) ? 0 : input_data.weight;
    
    `ifdef USEDSPMACRO
    xbip_multadd_0 mult_add (
        .A(new_input),
        .B(new_weight),
        .C(bias_or_accumulated),
        .SUBTRACT(0),
        .P(new_accumulated)
    );
    `else
    reg signed [31:0] s_new_accumulated;
    assign new_accumulated = s_new_accumulated;
    always @* begin
        s_new_accumulated = new_input * new_weight + bias_or_accumulated;
    end
    `endif


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
                SD_AXIS_TREADY = 0;
            end
            else begin
                instruction = DC; // don't care here. Once tvalid is a yea and the state changes, this should change to what it should be.
            end
        end
        else if (state == LOAD_BIAS) begin
            instruction = LOAD;
        end
        else begin
            instruction = MAC;
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
                        accumulator <= new_accumulated;
                        state <= MAC_W_AND_I;
                        if (SD_AXIS_TLAST) begin
                            state <= OUTPUT_RES;
                        end
                    end
                end
                MAC_W_AND_I: begin
                    if (SD_AXIS_TVALID) begin
                        accumulator <= new_accumulated;
                        if (SD_AXIS_TLAST) begin
                            state <= OUTPUT_RES;
                        end
                    end
                end
                OUTPUT_RES: begin
                    if (MO_AXIS_TREADY) begin // it should get our result... move on
                        if (SD_AXIS_TVALID && SD_AXIS_TLAST) begin
                            state <= OUTPUT_RES;
                            accumulator <= new_accumulated;
                        end
                        else if (SD_AXIS_TVALID) begin
                            state <= MAC_W_AND_I;
                            accumulator <= new_accumulated;
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