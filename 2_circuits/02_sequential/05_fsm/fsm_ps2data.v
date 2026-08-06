//==============================================================
// Problem : Fsm ps2data
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Fsm_ps2data
// Solved  : 2026-07-29
//--------------------------------------------------------------
// 저번 거 틀린 이유를 아니까 이번 건 쉬웠다.
//==============================================================

module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output reg [23:0] out_bytes,
    output done);
    
    // FSM from fsm_ps2
    parameter SEARCH = 0, NO = 1, BYTE3 = 2;
    reg [1:0] state, nextstate;
    reg [1:0] counter;
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            SEARCH : nextstate = in[3] ? NO : SEARCH;
            NO : nextstate = (counter > 0) ? BYTE3 : NO;
            BYTE3 : nextstate = in[3] ? NO : SEARCH;
            default : nextstate = state;
        endcase
    end
    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= SEARCH;
        end
        else begin
            state <= nextstate;
        end
        // Counters
        if (state == NO) begin
            counter <= counter + 1;
        end
        else begin
            counter <= 0;
        end
        // New: Datapath to store incoming bytes.
        if ((state == SEARCH & in[3]) | state == BYTE3 ) begin
            out_bytes[23:16] <= in;
        end
        else if ((state == NO) & counter == 0) begin
            out_bytes[15:8] <= in;
        end
        else if ((state == NO) & counter == 1) begin
            out_bytes[7:0] <= in;
        end
    end 
    // Output logic
    assign done = (state == BYTE3);endmodule
