//==============================================================
// Problem : Mt2015 muxdff
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Mt2015_muxdff
// Solved  : 2026-07-25
//--------------------------------------------------------------
// 헷갈린 부분:
// MUX 출력과 플립플롭 입력 사이의 중간 wire D가 직관적이지 않았다.
//==============================================================

module top_module (
    input clk,
    input L,
    input r_in,
    input q_in,
    output reg Q
);
    wire D;
    assign D = L ? r_in : q_in;
    always @(posedge clk) begin
        Q <= D;
    end
endmodule
