`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.12.2025 00:32:08
// Design Name: 
// Module Name: sv_output_storage
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


module sv_output_storage #(
        parameter DATA_WIDTH = 32,
        parameter BRAM_DATA_WIDTH = 32,
        parameter ADDR_WIDTH = 32,
        parameter BRAM_ADDR_WIDTH = 32,
        parameter DIM_WIDTH = 8,
        parameter C_TID_WIDTH = 1
    ) (
        output S_AXIS_TREADY,
        input [DATA_WIDTH-1 : 0] S_AXIS_TDATA,
        input S_AXIS_TLAST,
        input [C_TID_WIDTH-1 : 0] S_AXIS_TID,
        input S_AXIS_TVALID,
        
        output reg [32-1 : 0] BRAM_addr,
        output reg [BRAM_DATA_WIDTH-1 : 0] BRAM_din,
        input [BRAM_DATA_WIDTH-1 : 0] BRAM_dout,
        output reg BRAM_en,
        output reg [(BRAM_DATA_WIDTH/8)-1 : 0] BRAM_we,
        output BRAM_rst,
        output BRAM_clk,
        
        input max_pooling,
        input [ADDR_WIDTH-1 : 0] elements_per_channel,
        input [DIM_WIDTH-1 : 0] output_w,
        input [DIM_WIDTH-1 : 0] output_h,
        input [ADDR_WIDTH-1 : 0] initial_offset,
        
        output reg conv_complete,
        input conv_idle,
        input clk,
        input rst
    );
    
    
    // assuming getting in sequence of mac0, mac1, mac2, mac3, mac0, mac1, ...
    // assuming max pooling is 2x2
    // assuming dimensions are "nice"
    // conv_idle and conv_complete between each set of 4 filters
    // assuming initial_offset is even
    

    
   
    reg [DIM_WIDTH-1 : 0] column_progress;
    reg [DIM_WIDTH-1 : 0] row_progress;
    
    reg [ADDR_WIDTH-1 : 0] output_idx;
    
    
    reg [ADDR_WIDTH-1 : 0] offsetted_progress; // should be ahead index
    
    
    reg [ADDR_WIDTH-1 : 0] saved_base_row_idx;
    
    reg ready;
    assign S_AXIS_TREADY = ready;
    
    // indexing
    always @(posedge clk) begin
        if (rst || conv_idle) begin
            output_idx <= initial_offset;

            column_progress <= 1;
            row_progress <= 1;
            saved_base_row_idx <= initial_offset;
            offsetted_progress <= initial_offset;
            
            if (max_pooling) begin
                // output addr is idx divided by 2 so multiply the offset by 2
                output_idx <= {initial_offset[ADDR_WIDTH-2 : 0], 1'b0};
                saved_base_row_idx <= {initial_offset[ADDR_WIDTH-2 : 0], 1'b0};
                offsetted_progress <= {initial_offset[ADDR_WIDTH-2 : 0], 1'b0};
            end
            
        end
        else if (S_AXIS_TVALID && ready) begin
            if (S_AXIS_TID == 2) begin // do it before so it's ready
                offsetted_progress <= offsetted_progress + 1; // keep it one ahead. don't do this in the loading because then adder might be needed
                output_idx <= output_idx + elements_per_channel;
                if (max_pooling)
                    output_idx <= output_idx + {elements_per_channel[ADDR_WIDTH-2 : 0], 1'b0};
                               
                if (column_progress == 1)
                    saved_base_row_idx <= offsetted_progress;
                
            end
            else if (S_AXIS_TID == 3) begin
                output_idx <= offsetted_progress;
                
                column_progress <= column_progress + 1;
                if (max_pooling) begin
                    if ({1'b0, column_progress} == {1'b0, output_w}) begin // assuming pooling, output_w is half of what it would be if there wasn't pooling.
                        row_progress <= row_progress + 1;
                        column_progress <= 1;
                    
                        if (row_progress[0]) begin // if row_progress is odd.
                            output_idx <= saved_base_row_idx;
                            offsetted_progress <= saved_base_row_idx;
                        end
                    
                    end
                end
                else begin
                    if (column_progress == output_w) begin
                        row_progress <= row_progress + 1;
                        column_progress <= 1;
                    end
                end
                
            end
            else begin
                output_idx <= output_idx + elements_per_channel;
                if (max_pooling)
                    output_idx <= output_idx + {elements_per_channel[ADDR_WIDTH-2 : 0], 1'b0};
            end
            
        end
    end
    

    assign BRAM_clk = clk;
    assign BRAM_rst = rst;
    
    
    typedef enum logic {
        READ,
        WRITE
    } outstorage_state_t;
    
    typedef struct packed {
        logic [DATA_WIDTH-1:0] out_data;
        logic [BRAM_DATA_WIDTH-1:0] bram_read;
        logic [ADDR_WIDTH-1:0] out_idx;
        logic [C_TID_WIDTH-1:0] tid;
        logic [DIM_WIDTH-1:0] row_progress;
        logic [DIM_WIDTH-1:0] col_progress;
    } pline_t;
    
    outstorage_state_t state;
    
    pline_t pline;
    /*reg [DATA_WIDTH-1 : 0] p_output_data;
    reg [BRAM_DATA_WIDTH-1 : 0] p_bram_read;
    reg [ADDR_WIDTH-1 : 0] p_output_idx;
    reg [DIM_WIDTH-1 : 0] p_col_progress;
    reg [DIM_WIDTH-1 : 0] p_row_progress;    
    reg [C_TID_WIDTH-1 : 0] p_tid;*/
    
    
    always @* begin
        if (state == READ) begin
            ready = 1;
            if (max_pooling)
                BRAM_addr = $unsigned({output_idx[ADDR_WIDTH-1 : 3], 2'b00}); // divided by 2 and 32 bit align
            else
                BRAM_addr = $unsigned({output_idx[ADDR_WIDTH-1 : 2], 2'b00}); // 32 bit align and 0 pad
            
            BRAM_we = 0;
            BRAM_din = 0;
            if (S_AXIS_TVALID)
                BRAM_en = 1;
            else
                BRAM_en = 0;
        end
        else if (state == WRITE) begin
            ready = 0;
            if (max_pooling)
                BRAM_addr = $unsigned({pline.out_idx[ADDR_WIDTH-1 : 3], 2'b00}); // divided by 2 and 32 bit align
            else
                BRAM_addr = $unsigned({pline.out_idx[ADDR_WIDTH-1 : 2], 2'b00}); //32 bit align and 0 pad
            BRAM_en = 1;
            BRAM_we = 4'b1111;
            
            if (max_pooling) begin
                // odd row and odd column -> top left of 2x2 pool block -> First element
                if (pline.col_progress[0] && pline.row_progress[0]) begin
                    case (pline.out_idx[2:1])
                        2'b00: BRAM_din = {BRAM_dout[31:8], pline.out_data[7:0]};
                        2'b01: BRAM_din = {BRAM_dout[31:16], pline.out_data[7:0], BRAM_dout[7:0]};
                        2'b10: BRAM_din = {BRAM_dout[31:24], pline.out_data[7:0], BRAM_dout[15:0]};
                        2'b11: BRAM_din = {pline.out_data[7:0], BRAM_dout[23:0]};
                        default: BRAM_din = 0;
                    endcase
                end
                else begin
                    // load if bigger
                    case (pline.out_idx[2:1])
                        2'b00: BRAM_din = {BRAM_dout[31:8], ($signed(pline.out_data[7:0]) > $signed(BRAM_dout[7:0])) ? pline.out_data[7:0] : BRAM_dout[7:0]};
                        2'b01: BRAM_din = {BRAM_dout[31:16], ($signed(pline.out_data[7:0]) > $signed(BRAM_dout[15:8])) ? pline.out_data[7:0] : BRAM_dout[15:8], BRAM_dout[7:0]};
                        2'b10: BRAM_din = {BRAM_dout[31:24], ($signed(pline.out_data[7:0]) > $signed(BRAM_dout[23:16])) ? pline.out_data[7:0] : BRAM_dout[23:16], BRAM_dout[15:0]};
                        2'b11: BRAM_din = {($signed(pline.out_data[7:0]) > $signed(BRAM_dout[31:24])) ? pline.out_data[7:0] : BRAM_dout[31:24], BRAM_dout[23:0]};
                        default: BRAM_din = 0;
                    endcase
                end
            end
            else begin
                case (pline.out_idx[1:0])
                    2'b00: BRAM_din = {BRAM_dout[31:8], pline.out_data[7:0]};
                    2'b01: BRAM_din = {BRAM_dout[31:16], pline.out_data[7:0], BRAM_dout[7:0]};
                    2'b10: BRAM_din = {BRAM_dout[31:24], pline.out_data[7:0], BRAM_dout[15:0]};
                    2'b11: BRAM_din = {pline.out_data[7:0], BRAM_dout[23:0]};
                    default: BRAM_din = 0;
                endcase
            end
            
        end
        else begin
            ready = 0;
            BRAM_addr = 0;
            BRAM_we = 0;
            BRAM_din = 0;
            BRAM_en = 0;
        end
        
        if (rst || conv_complete || conv_idle) begin
            BRAM_en = 0;
            BRAM_we = 0;
        end
        
    end
    

    
    always @(posedge clk) begin
        if (rst || conv_idle) begin
            state <= READ;
            conv_complete <= 0;
        end
        else begin
            case(state)
                READ: begin
                
                    if (S_AXIS_TVALID && !conv_complete) begin
                        state <= WRITE;
                        pline.out_data <= S_AXIS_TDATA;
                        pline.bram_read <= BRAM_dout;
                        pline.out_idx <= output_idx;
                        pline.tid <= S_AXIS_TID;
                        pline.col_progress <= column_progress;
                        pline.row_progress <= row_progress;
                    end
                
                end
                WRITE: begin
                    state <= READ;
                    
                    if (pline.tid == 3 && pline.row_progress == output_h && pline.col_progress == output_w)
                        conv_complete <= 1;
                    
                end
                default: begin
                    state <= READ;
                end
            endcase
        end
    end
    
    
endmodule
