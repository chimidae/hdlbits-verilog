//==============================================================
// Problem : Dff
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Dff
// Solved  : 2026-07-24
//--------------------------------------------------------------
// 풀이:
// posedge clk에서 입력 d를 q에 할당했다.
//==============================================================

module top_module (
    input clk,    // Clocks are used in sequential circuits
    input d,
    output reg q );
    always @(posedge clk) begin
        q = d;
    end
endmodule
