//==============================================================
// Problem : Exams/2014 q4b
// Section : Circuits / Sequential / Shift Registers
// URL     : https://hdlbits.01xz.net/wiki/Exams/2014_q4b
// Solved  : 2026-07-28
//--------------------------------------------------------------
// 헷갈린 부분:
// Exams/2014 q4a에서 만든 MUXDFF를 네 개 인스턴스화해 체인으로
// 잇는다. u0의 w만 외부 입력(KEY[3])이고 나머지는 앞단의 Q를 받는다.
//
// 삼항 중첩에서 L이 E보다 바깥에 있어야 로드가 우선이 된다.
//     Q <= L ? R : (E ? w : Q);
// E도 L도 0이면 Q를 그대로 넣어 유지한다.
//==============================================================

module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
);
    MUXDFF u0 (.clk(KEY[0]), .w(KEY[3]), .R(SW[3]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[3]));
    MUXDFF u1 (.clk(KEY[0]), .w(LEDR[3]), .R(SW[2]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[2]));
    MUXDFF u2 (.clk(KEY[0]), .w(LEDR[2]), .R(SW[1]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[1]));
    MUXDFF u3 (.clk(KEY[0]), .w(LEDR[1]), .R(SW[0]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[0]));
endmodule

module MUXDFF (
    input clk,
    input w, R, E, L,
    output Q
);
    always @(posedge clk) begin
        Q <= ( L ? R : (E ? w : Q));
    end
endmodule
