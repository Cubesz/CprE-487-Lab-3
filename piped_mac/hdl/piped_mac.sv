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

module piped_mac #(parameter C_DATA_WIDTH = 8) (
        input ACLK,
        input ARESETN,
        
        output reg SD_AXIS_TREADY,
        input [C_DATA_WIDTH*2-1 : 0] SD_AXIS_TDATA,
        input SD_AXIS_TLAST,
        input [31:0] SD_AXIS_TUSER,
        input SD_AXIS_TVALID,
        input [7:0] SD_AXIS_TID,
        
        output reg MO_AXIS_TVALID,
        output [31:0] MO_AXIS_TDATA,
        output reg MO_AXIS_TLAST,
        input MO_AXIS_TREADY,
        output reg [7:0] MO_AXIS_TID
    );
    
    typedef enum logic [1:0] {TAKE_IN_INIT_WEIGHT_INPUT_BIAS, TAKE_IN_WEIGHTS_AND_INPUTS, DELAY, OUTPUT_RESULT} STATE_TYPE;
    
    wire [31:0] mac_debug = 0;
    
    STATE_TYPE state;
    
        
    
//    multadd_8x8p32_piped mult_add_accumulator (
//          .CLK(ACLK),
//          .CE(mult_add_accum_ce),
//          .SCLR(mult_add_accum_sclr),
//          .A(new_input),
//          .B(new_weight),
//          .PCIN(cascaded_accumulator_out),
//          .SUBTRACT(0),
//          .P(accumulator_out),
//          .PCOUT(cascaded_accumulator_out)
//    );
    
    typedef enum logic [1:0] {
        MULT_ADD_LOAD = 0,
        MULT_ADD_ACCUM = 1,
        HOLD = 2
    } custom_mult_add_instruction_t;
    
    typedef struct packed {
        logic signed [C_DATA_WIDTH - 1 : 0] inp;
        logic signed [C_DATA_WIDTH - 1 : 0] weight;
    } input_data_t;
    
    custom_mult_add_instruction_t instruction;
    
    wire [47:0] cascaded_accumulator_out;
    wire [31:0] accumulator_out;
    assign MO_AXIS_TDATA = accumulator_out; // it shouldn't sample it until its ready
    
    input_data_t input_mult_data;
    wire signed [31:0] new_bias;
    assign input_mult_data = input_data_t'(SD_AXIS_TDATA);
    assign new_bias = SD_AXIS_TUSER;

    dsp48_custom_mult_add_piped mult_add (
        .CLK(ACLK),
        .SEL(instruction),
        .PCIN(cascaded_accumulator_out),
        .A(input_mult_data.inp),
        .B(input_mult_data.weight),
        .C(new_bias),
        .P(accumulator_out),
        .PCOUT(cascaded_accumulator_out)
    );

    always @* begin
        instruction = HOLD;
        if (state == TAKE_IN_INIT_WEIGHT_INPUT_BIAS) begin
            instruction = MULT_ADD_LOAD;
        end
        else if (state == TAKE_IN_WEIGHTS_AND_INPUTS) begin
            instruction = MULT_ADD_ACCUM;
        end
        else if (state == DELAY) begin
            instruction = HOLD;
        end
        else if (state == OUTPUT_RESULT) begin
            instruction = HOLD;
            if (MO_AXIS_TREADY && SD_AXIS_TVALID) begin
                instruction = MULT_ADD_LOAD;
            end
        end
        
        if (!SD_AXIS_TVALID) begin
            instruction = HOLD;
        end
        
    end
    
    always @* begin
        SD_AXIS_TREADY = 1;
        if (ARESETN == 0) begin
            SD_AXIS_TREADY = 0;
        end
        else if (state == DELAY) begin
            SD_AXIS_TREADY = 0;
        end
        else if (state == OUTPUT_RESULT) begin
            SD_AXIS_TREADY = 0;
            if (MO_AXIS_TREADY && SD_AXIS_TVALID) begin
                SD_AXIS_TREADY = 1;
            end
        end
    end
    
    reg delay_counter;
    always @(posedge ACLK) begin
        MO_AXIS_TVALID <= 0;
        MO_AXIS_TLAST <= 0;
        MO_AXIS_TID <= 0;
        if (ARESETN == 0) begin // is in reset
            //state <= WAIT_FOR_BIAS;
            state <= TAKE_IN_INIT_WEIGHT_INPUT_BIAS;
            SD_AXIS_TREADY <= 0;
            delay_counter <= 0;
        end
        else begin
            case (state)
                TAKE_IN_INIT_WEIGHT_INPUT_BIAS: begin
                    state <= TAKE_IN_INIT_WEIGHT_INPUT_BIAS;
                    if (SD_AXIS_TVALID) begin
                        state <= TAKE_IN_WEIGHTS_AND_INPUTS;
                        if (SD_AXIS_TLAST) begin
                            state <= DELAY;
                            MO_AXIS_TVALID <= 0;
                            MO_AXIS_TLAST <= 0;
                            delay_counter <= 0;
                        end
                    end
                end
                TAKE_IN_WEIGHTS_AND_INPUTS: begin
                    if (SD_AXIS_TVALID) begin
                        if (SD_AXIS_TLAST) begin
                            state <= DELAY;
                            //state <= OUTPUT_RESULT;
                            MO_AXIS_TVALID <= 0;
                            MO_AXIS_TLAST <= 0;
                            delay_counter <= 0;
                        end
                    end
                end
                DELAY: begin
                    delay_counter <= delay_counter + 1;
                    if (delay_counter == 1) begin
                        state <= OUTPUT_RESULT;
                        MO_AXIS_TVALID <= 1;
                        MO_AXIS_TLAST <= 1;
                    end
                end
                OUTPUT_RESULT: begin
                    MO_AXIS_TLAST <= 1;
                    MO_AXIS_TVALID <= 1;
                    if (MO_AXIS_TREADY) begin // it should get our result... move on. If its TVALID, that means that new data is trying to be sent to us and they don't care for capturing the output (as would be indicated if MO_AXIS_TREADY went high instead)
                        // If our output wasn't captured, and data was sent to us instead. Data is immidiatelly available in the the case of TVALID, though we will stall and use it later as for this cycle, we need to reset the accumulator
                        
                        if (SD_AXIS_TVALID && SD_AXIS_TLAST) begin
                            state <= DELAY;
                            delay_counter <= 0;
                        end
                        else if (SD_AXIS_TVALID) begin
                            state <= TAKE_IN_WEIGHTS_AND_INPUTS;
                        end
                        else begin
                            state <= TAKE_IN_INIT_WEIGHT_INPUT_BIAS;
                        end
                        
                        MO_AXIS_TVALID <= 0; // Even if tvalid is high and there is something available for us, don't take it in this case; we cant load while we are clearing and we cant load without it being cleared first. (our accumulator is a register inside the multiply add IP and we don't have a load option with it)
                        MO_AXIS_TLAST <= 0; //
                    end
                end
                default: begin
                    //state <= WAIT_FOR_BIAS;
                    state <= TAKE_IN_INIT_WEIGHT_INPUT_BIAS;
                end
            endcase
        end
    end
    
    
endmodule