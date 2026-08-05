//==============================================================
// Problem : Edgedetect
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Edgedetect
// Solved  : 2026-07-27
//--------------------------------------------------------------
// 3회 실패. 힌트를 받아 해결.
// 1차: save 없이 pedge를 직접 껐다 켜려 함. 파형에서 in이 1로
//      유지되는 동안 pedge가 반복 진동하는 것을 확인.
// 2차: save를 도입했으나 if 블록 안에서 조건부로 갱신함.
// 3차: if (~save & in)으로 벡터를 조건 자리에 넣음.
//==============================================================

module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    wire [7:0] save;
    always @(posedge clk) begin
        save  <= in;
        pedge <= ~save & in;
    end
endmodule
