//==============================================================
// Problem : Count10
// Section : Circuits / Sequential / Counters
// URL     : https://hdlbits.01xz.net/wiki/Count10
// Solved  : 2026-07-27
//--------------------------------------------------------------
// 1차 시도에서 랩 조건을 q >= 10으로 걸어 FAIL.
//==============================================================

module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);
    always @(posedge clk) begin
        if (reset | q >= 9) begin
            q <= 4'b0;
        end
        else begin
            q <= q + 1;
        end
    end
endmodule
