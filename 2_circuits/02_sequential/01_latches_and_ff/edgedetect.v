//==============================================================
// Problem : Edgedetect
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Edgedetect
// Solved  : 2026-07-27
//--------------------------------------------------------------
// 헷갈린 부분:
// pedge를 "관리해야 할 상태"로 보고 if로 껐다 켰다 하려다 계속 실패했다.
// 실제로는 save에 직전 in을 넣어두고 ~save & in을 매 사이클 그대로
// 찍는 것이 전부다. save가 한 클럭 뒤에 따라잡으면서 식이 저절로
// 0이 되므로 억제 로직이 필요 없다.
// if (벡터)는 리덕션 OR로 접혀서 8비트가 한 판단으로 뭉개진다.
// 비트별 독립을 유지하려면 비트와이즈 연산만 써야 한다.
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
