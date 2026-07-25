//==============================================================
// Problem : Exams/2014 q4a
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Exams/2014_q4a
// Solved  : 2026-07-25
//--------------------------------------------------------------
// 헷갈린 부분:
// 처음에는 플립플롭 출력 Q를 피드백 신호 o에 연결하는 것을 빠뜨렸다.
//==============================================================

module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    wire D, o, a;
    assign a = E ? w : o;
    assign D = L ? R : a;
    always @(posedge clk) begin
        Q <= D;
    end
    assign o = Q;

endmodule
