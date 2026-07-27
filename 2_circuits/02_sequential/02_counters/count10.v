//==============================================================
// Problem : Count10
// Section : Circuits / Sequential / Counters
// URL     : https://hdlbits.01xz.net/wiki/Count10
// Solved  : 2026-07-27
//--------------------------------------------------------------
// 헷갈린 부분:
// 1차 시도에서 q >= 10으로 랩 조건을 걸어 주기가 11이 됐다.
// 조건은 지금 값으로 검사하고 결과는 다음 값에 반영되므로,
// q가 10이 되는 순간은 존재하지 않는다. mod-N 카운터는 항상
// N-1을 검사해야 한다.
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
