//==============================================================
// Problem : Count1to10
// Section : Circuits / Sequential / Counters
// URL     : https://hdlbits.01xz.net/wiki/Count1to10
// Solved  : 2026-07-27
//--------------------------------------------------------------
// 헷갈린 부분:
// 시작값이 0이 아니라 1이므로 reset과 랩 모두 4'b0001로 민다.
// 랩 조건은 최대값인 10을 그대로 검사한다.
// else 분기에 blocking(=)을 썼는데 분기가 배타적이라 통과했다.
// 순차 회로는 non-blocking(<=)으로 통일하는 것이 원칙이다.
//==============================================================

module top_module (
    input clk,
    input reset,
    output [3:0] q);
    always @(posedge clk) begin
        if (reset | q >= 10) begin
            q <= 4'b0001;
        end
        else begin
            q = q + 1;
        end
    end
endmodule
