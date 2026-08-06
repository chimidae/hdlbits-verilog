//==============================================================
// Problem : Fsm ps2
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Fsm_ps2
// Solved  : 2026-07-29
//--------------------------------------------------------------
// 1차 시도에서 counter > 1로 작성해 FAIL. 간격은 맞는데 첫 done이
// 한 칸 밀렸다. counter > 0으로 고쳐 통과.
//==============================================================

module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done);
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
    end 
    // Output logic
    assign done = (state == BYTE3);
endmodule
