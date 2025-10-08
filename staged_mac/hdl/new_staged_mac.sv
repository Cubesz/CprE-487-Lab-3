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
        output reg [7:0] MO_AXIS_TID
    );
    
    typedef enum logic {TAKE_IN_WEIGHTS_AND_INPUTS, OUTPUT_RESULT} STATE_TYPE;
    
    wire [31:0] mac_debug = 0;
    
    STATE_TYPE state;
    
    reg [31:0] accumulator;
        
    wire [C_DATA_WIDTH - 1 : 0] new_weight = SD_AXIS_TDATA[C_DATA_WIDTH - 1 : 0];
    wire [C_DATA_WIDTH - 1 : 0] new_input = SD_AXIS_TDATA[C_DATA_WIDTH * 2 - 1 : C_DATA_WIDTH];
    
    wire signed [31:0] new_accumulated;
    assign MO_AXIS_TDATA = accumulator; // it shouldn't sample it until its ready
    
    multadd_8x8p32_com mult_add (
          .A(new_input),
          .B(new_weight),
          .C(accumulator),
          .SUBTRACT(0),
          .P(new_accumulated)
    );

    
//    reg signed [31:0] product;
//    reg signed [31:0] new_accumulated;
//    always @* begin
//        product = $signed(new_weight) * $signed(new_input);
//        new_accumulated = $signed(accumulator) + product;
//    end
    

    
    always @(posedge ACLK) begin
        SD_AXIS_TREADY <= 1;
        MO_AXIS_TVALID <= 0;
        MO_AXIS_TLAST <= 0;
        MO_AXIS_TID <= 0;
        if (ARESETN == 0) begin // is in reset
            //state <= WAIT_FOR_BIAS;
            state <= TAKE_IN_WEIGHTS_AND_INPUTS;
            accumulator <= 0;
            SD_AXIS_TREADY <= 0;
        end
        else begin
            case (state)
//                WAIT_FOR_BIAS: begin // Bias state not needed, why multiplex input into accumulator? Just send something like 1 * bias instead in the beginning or whenever. 
//                    if (SD_AXIS_TVALID) begin
//                        accumulator <= $signed(SD_AXIS_TDATA);
//                        state <= TAKE_IN_WEIGHTS_AND_INPUTS;
//                    end
//                end
                TAKE_IN_WEIGHTS_AND_INPUTS: begin
                    if (SD_AXIS_TVALID) begin
                        accumulator <= new_accumulated;
                        if (SD_AXIS_TLAST) begin
                            state <= OUTPUT_RESULT;
                            SD_AXIS_TREADY <= 0;
                            MO_AXIS_TVALID <= 1;
                            MO_AXIS_TLAST <= 1;
                        end
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
                        MO_AXIS_TLAST <= 1;
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