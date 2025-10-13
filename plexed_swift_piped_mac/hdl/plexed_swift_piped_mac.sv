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

`define USEDSPMACRO

module plexed_swift_piped_mac #(parameter C_DATA_WIDTH = 8) (
        input ACLK,
        input ARESETN,
        
        output reg SD_AXIS_TREADY,
        input [C_DATA_WIDTH*2-1 : 0] SD_AXIS_TDATA,
        input SD_AXIS_TLAST,
        input SD_AXIS_TUSER,
        input SD_AXIS_TVALID,
        input [7:0] SD_AXIS_TID,
        
        output MO_AXIS_TVALID,
        output [31:0] MO_AXIS_TDATA,
        output MO_AXIS_TLAST,
        input MO_AXIS_TREADY,
        output [7:0] MO_AXIS_TID
    );
    
    typedef enum logic { LOAD_BIAS, MAC_W_AND_I } STATE_TYPE;
    
    
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
    
    wire [31:0] accumulator_out;
    assign MO_AXIS_TDATA = accumulator_out; // it shouldn't sample it until its ready
    
    input_data_t input_mult_data;
    wire signed [15:0] new_bias;
    assign input_mult_data = input_data_t'(SD_AXIS_TDATA);
    assign new_bias = SD_AXIS_TDATA;
    
    wire signed [C_DATA_WIDTH - 1:0] new_input;
    wire signed [C_DATA_WIDTH - 1:0] new_weight;
    wire signed [31:0] accumulated_or_pipedbias;
    assign new_input = (instruction == LOAD || instruction == NOOP) ? 0 : input_mult_data.inp;
    assign new_weight = (instruction == LOAD || instruction == NOOP) ? 0 : input_mult_data.weight;
    assign accumulated_or_pipedbias = p2load ? $signed({ {16{Cpipe2[15]}} , Cpipe2}) : accumulator_out;
    reg signed [15:0] Cpipe1, Cpipe2;
    always @(posedge ACLK) begin
        Cpipe1 <= ARESETN ? new_bias : 0;
        Cpipe2 <= Cpipe1;
    end
    
     wire signed [C_DATA_WIDTH * 2 - 1:0] product;
     multer mult (
        .CLK(ACLK),
        .A(new_input),
        .B(new_weight),
        .P(product)
     );
     
     adder addr (
        .CLK(ACLK),
        .A(product),
        .B(accumulated_or_pipedbias),
        .S(accumulator_out)
     );

   
    // pipeline parallel
    reg p1, p2, output_ready;
    reg p1load, p2load;
    always @(posedge ACLK) begin
        if (ARESETN == 0) begin
            p1 <= 0;
            p2 <= 0;
            output_ready <= 0;
            p1load <= 0;
            p2load <= 0;
        end
        else begin
            p1load <= (instruction == LOAD) ? 1 : 0;
            p2load <= p1load;
            p1 <= SD_AXIS_TVALID & SD_AXIS_TLAST;
            p2 <= p1;
            output_ready <= p2;
       end
    end
    
    assign MO_AXIS_TVALID = output_ready & ARESETN;
    assign MO_AXIS_TLAST = output_ready & ARESETN;
    assign MO_AXIS_TID = 0;
    
    always @* begin

        if (state == LOAD_BIAS) begin
            instruction = LOAD;
        end
        else begin
            instruction = MAC;
        end
        
        if (!SD_AXIS_TVALID) begin
            instruction = NOOP;
        end
        
        
        if (!ARESETN) begin
            SD_AXIS_TREADY = 0;
            instruction = NOOP;
        end
        else begin
            SD_AXIS_TREADY = 1;
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
                    end;
                end
                MAC_W_AND_I: begin
                    if (SD_AXIS_TVALID && SD_AXIS_TLAST) begin
                        state <= LOAD_BIAS;
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
