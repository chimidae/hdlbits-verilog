//==============================================================
// Problem : Exams/m2014 q4d
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Exams/m2014_q4d
// Solved  : 2026-07-25
//--------------------------------------------------------------
// 헷갈린 부분:
// 처음에는 D 계산, Q 저장, out 연결을 모두 posedge 블록에 넣었다.
// 그러면 D와 out도 클럭 엣지에서만 갱신되는 저장소가 되고,
// non-blocking 할당의 Q <= D는 같은 엣지에서 계산한 D가 아니라
// 이전 D 값을 읽는다. 이 회로에서는 D와 out은 조합 연결이고 Q만 FF다.
//==============================================================

module top_module (
    input clk,
    input in, 
    output out
);
    wire D,Q;
    assign D = in ^ Q;
    always @(posedge clk) begin
        Q <= D;
    end
    assign out = Q;

endmodule
