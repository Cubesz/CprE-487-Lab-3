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

module new_piped_mac #(parameter C_DATA_WIDTH = 8) (
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
        output reg [7:0] MO_AXIS_TID
    );
    
    typedef enum logic [1:0] {TAKE_IN_WEIGHTS_AND_INPUTS, DELAY, OUTPUT_RESULT} STATE_TYPE;
    
    wire [31:0] mac_debug = 0;
    
    STATE_TYPE state;
    
        
    wire [C_DATA_WIDTH - 1 : 0] new_weight = SD_AXIS_TDATA[C_DATA_WIDTH - 1 : 0];
    wire [C_DATA_WIDTH - 1 : 0] new_input = SD_AXIS_TDATA[C_DATA_WIDTH * 2 - 1 : C_DATA_WIDTH];
    
    
    wire [47:0] cascaded_accumulator_out;
    wire [31:0] accumulator_out;
    
    assign MO_AXIS_TDATA = accumulator_out; // it shouldn't sample it until its ready
    
    reg mult_add_accum_ce;
    reg mult_add_accum_sclr;
    always @* begin // combinatorial because we want to control clock enable and sclr without delay. Use clock enable to stop the internal accumulator from updating when relevant
        // sclr only works when ce
        mult_add_accum_ce = 1;
        mult_add_accum_sclr = 0;
        
        if (!ARESETN) begin
            mult_add_accum_ce = 1;
            mult_add_accum_sclr = 1;
        end
        else if (state == TAKE_IN_WEIGHTS_AND_INPUTS && SD_AXIS_TVALID) begin
            mult_add_accum_ce = 1;
            mult_add_accum_sclr = 0;
        end
        else if (state == TAKE_IN_WEIGHTS_AND_INPUTS) begin // sd_axis_tvalid is false here
            mult_add_accum_ce = 0; // freeze it
        end
        
        
        if (state == OUTPUT_RESULT && MO_AXIS_TREADY) begin
            mult_add_accum_ce = 1;
            mult_add_accum_sclr = 1;
        end
        else if (state == OUTPUT_RESULT) begin // mo_axis_tready is false here
            mult_add_accum_ce = 0; // freeze it.
        end
        

    end
    
    multadd_8x8p32_piped mult_add_accumulator (
          .CLK(ACLK),
          .CE(mult_add_accum_ce),
          .SCLR(mult_add_accum_sclr),
          .A(new_input),
          .B(new_weight),
          .PCIN(cascaded_accumulator_out),
          .SUBTRACT(0),
          .P(accumulator_out),
          .PCOUT(cascaded_accumulator_out)
    );

    
    reg delay_counter;
    
    always @(posedge ACLK) begin
        SD_AXIS_TREADY <= 1;
        MO_AXIS_TVALID <= 0;
        MO_AXIS_TLAST <= 0;
        MO_AXIS_TID <= 0;
        if (ARESETN == 0) begin // is in reset
            //state <= WAIT_FOR_BIAS;
            state <= TAKE_IN_WEIGHTS_AND_INPUTS;
            SD_AXIS_TREADY <= 0;
            delay_counter <= 0;
        end
        else begin
            case (state)
                TAKE_IN_WEIGHTS_AND_INPUTS: begin
                    if (SD_AXIS_TVALID) begin
                        if (SD_AXIS_TLAST) begin
                            state <= DELAY;
                            //state <= OUTPUT_RESULT;
                            SD_AXIS_TREADY <= 0;
                            MO_AXIS_TVALID <= 0;
                            MO_AXIS_TLAST <= 0;
                            delay_counter <= 0;
                        end
                    end
                end
                DELAY: begin
                    SD_AXIS_TREADY <= 0;
                    delay_counter <= delay_counter + 1;
                    if (delay_counter == 1) begin
                        state <= OUTPUT_RESULT;
                        MO_AXIS_TVALID <= 1;
                        MO_AXIS_TLAST <= 1;
                    end
                end
                OUTPUT_RESULT: begin
                    SD_AXIS_TREADY <= 0;
                    MO_AXIS_TVALID <= 1;
                    if (MO_AXIS_TREADY) begin // it should get our result... move on
                        //state <= WAIT_FOR_BIAS;
                        state <= TAKE_IN_WEIGHTS_AND_INPUTS;
                        SD_AXIS_TREADY <= 1;
                        MO_AXIS_TVALID <= 0;
                        MO_AXIS_TLAST <= 0; //
                    end
                end
                default: begin
                    //state <= WAIT_FOR_BIAS;
                    state <= TAKE_IN_WEIGHTS_AND_INPUTS;
                end
            endcase
        end
    end
    
    
endmodule